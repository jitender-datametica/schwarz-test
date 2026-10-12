/********************************************************************************************************************************************
Setzt den Success-Status_1 der übergebenen Contexte (Mehrzahl) (gegeben durch eine_1 CTX-LID und eine_1 kommaseparierte Liste von AREA-Codes).
Wann macht dies Sinn?: Eine_1 Context-Rezipientengruppe (- z.B in einem Job) läuft und loggt ihre Durchläufe und damit die Konsumption der Daten einer TCACHE-Tabelle.
Möglicherweise beendet sich dieser Job - aber ohne  daß alle Konsumenten enthalten waren. In diesem Falle würde der Context auf "possibly running or broken" stehen.

Ein weiterer Job könnte deshalb die Arbeit am Context nicht aufnehmen, da nur "frische" Contexte (Status_1 "raw") hier gelesen werden können.
Einzige Ausnahme_1 war der geschützte Modus "reload".
Für den geschilderten Fall wurden weitere geschützte Modi erfunden. Sie tragen das Pattern "waiting_for[01...99]".

Diese Modi verhalten sich wie der reload-Modus. Für diesen jedoch würde während des gesamten Prozesswolkendurchlauf der Status_1 nicht mehr geändert
- außer bei ready = Gesamtdurchlauf mit Erfolg.
Für den wait_for-Modus wollen wir das Normale Logging der Stati wieder enablen. Zu diesem Zwecke muß ein zweiter Job den wait-for-Modus wieder auf raw zurücksetzen -
und falls dies immer noch nicht alle Prozesse waren anschließend wieder auf wait_for setzen (Hier käme dann die Nummerierung zum Einsatz).

Diese Routine ermöglich standardisiert den geschilderten RESET.
Das Pendant zu dieser Routine ist die Routine p_lc_p_lew_process_alter_success_state_ctx_lid oder ein manuelles Update auf die Task-Tabelle, welches (immer für eine_1 Ganze CTX_ID !!!)
den status_1 auf "waiting_for" setzt.

ctx_lid:            CONTEXT_LOAD_ID für den der Dispatcher laden möchte (sofern durch Stager freigegeben)
ctx_area_cds:       Kommaseparierte Liste von CONTEXT_AREA_CODES für die angegebene CONTEXT_LOAD_ID des parametrisierten Hierarchielevels (used_area_grp_type) und
                    bei Hierarchielevel=CLUSTER des CLustertypes (used_cluster_type)
                    OHNE EinSchluss der Codes in Hochkommata!!!
used_area_grp_type: Für die Übersetzung gewählter AREA_TYPE (= Level der Areale) [COUNTRY_1,CLUSTER,ALL]
used_cluster_type:  Wird in "used_area_grp_type" das Level CLUSTER verwendet, so muss bedacht werden, daß es verschiedene parallel
                        existente Clusterungen von Ländern gibt. Daher muss zusätzlich spezifiziert werden,
                        welche davon herangezogen werden soll - aktuell [SAP, POS]
                    Wird in "used_area_grp_type" das Level COUNTRY_1 oder ALL verwendet, gibt es nur den CLUSTER-Type [-]
                        - also naturgemäß keine Unterscheidung
set_success_state_to: Ziel-Success-Status_1 (i.a. "raw") setzt den success-status_1 künstlich auf den übergebenen Wert

(c) Infomotion GmbH 20200225 Jens Thole
*********************************************************************************************************************************************/
CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_alter_success_state_ctx_areas(IN CTX_LID FLOAT64, IN CTX_AREA_CDS STRING, IN USED_AREA_GRP_TYPE STRING, IN USED_CLUSTER_TYPE STRING, IN SET_SUCCESS_STATE_TO STRING, OUT out_param STRING)
BEGIN
DECLARE REAL_CLUSTER_TYPE STRING;
DECLARE sql_command STRING;
DECLARE stmt STRING;
DECLARE res STRING;
BEGIN
SET REAL_CLUSTER_TYPE  =  USED_CLUSTER_TYPE;
END;
----Sicherheitshalber wird ausgeschlossen, dass der Cluster-Type für die Level COUNTRY_1 und ALL falsch gesetzt werden kann:

BEGIN

IF USED_AREA_GRP_TYPE <> 'CLUSTER' THEN
    BEGIN
    SET REAL_CLUSTER_TYPE  =  '-';
    END;
END IF;

END;
BEGIN
--BUILD STATEMENT_1

SET sql_command  =  '''UPDATE p_lew_process.t_lc_prtcl_context_tasks_1 SET  success_state = @SET_SUCCESS_STATE_TO WHERE context_load_id = @CTX_LID AND context_country_cd IN (SELECT v_etl_context_orga_area.country_cd    FROM p_lew_process.v_etl_context_orga_area_1     INNER JOIN (SELECT "," || @CTX_AREA_CDS || "," AS arealist) AS cl ON cl.arealist LIKE "%," ||        v_etl_context_orga_area.area_cd || ",%"    WHERE v_etl_context_orga_area.area_grp_type = @USED_AREA_GRP_TYPE     AND v_etl_context_orga_area.cluster_type = @REAL_CLUSTER_TYPE) ''';
--RUN STATEMENT_1

SET stmt  =  sql_command;

EXECUTE IMMEDIATE (stmt)
 USING SET_SUCCESS_STATE_TO AS SET_SUCCESS_STATE_TO,  CTX_LID AS CTX_LID,  CTX_AREA_CDS AS CTX_AREA_CDS,  USED_AREA_GRP_TYPE AS USED_AREA_GRP_TYPE,  REAL_CLUSTER_TYPE AS REAL_CLUSTER_TYPE;
EXCEPTION
WHEN ERROR THEN
-- Return a success/error indicator.

SET out_param  =  'Failed: ' || @@ERROR.MESSAGE;
SELECT out_param;
RETURN;
END;
END;
