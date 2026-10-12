CREATE OR REPLACE PROCEDURE p_lew_process.p_lc_p_lew_process_alter_success_state_ctx_areas (CTX_LID FLOAT,CTX_AREA_CDS STRING, USED_AREA_GRP_TYPE STRING, USED_CLUSTER_TYPE STRING, SET_SUCCESS_STATE_TO STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$

/********************************************************************************************************************************************
Setzt den Success-Status der übergebenen Contexte (Mehrzahl) (gegeben durch eine CTX-LID und eine kommaseparierte Liste von AREA-Codes).
Wann macht dies Sinn?: Eine Context-Rezipientengruppe (- z.B in einem Job) läuft und loggt ihre Durchläufe und damit die Konsumption der Daten einer TCACHE-Tabelle.
Möglicherweise beendet sich dieser Job - aber ohne  daß alle Konsumenten enthalten waren. In diesem Falle würde der Context auf "possibly running or broken" stehen.

Ein weiterer Job könnte deshalb die Arbeit am Context nicht aufnehmen, da nur "frische" Contexte (Status "raw") hier gelesen werden können.
Einzige Ausnahme war der geschützte Modus "reload".
Für den geschilderten Fall wurden weitere geschützte Modi erfunden. Sie tragen das Pattern "waiting_for[01...99]".

Diese Modi verhalten sich wie der reload-Modus. Für diesen jedoch würde während des gesamten Prozesswolkendurchlauf der Status nicht mehr geändert
- außer bei ready = Gesamtdurchlauf mit Erfolg.
Für den wait_for-Modus wollen wir das Normale Logging der Stati wieder enablen. Zu diesem Zwecke muß ein zweiter Job den wait-for-Modus wieder auf raw zurücksetzen -
und falls dies immer noch nicht alle Prozesse waren anschließend wieder auf wait_for setzen (Hier käme dann die Nummerierung zum Einsatz).

Diese Routine ermöglich standardisiert den geschilderten RESET.
Das Pendant zu dieser Routine ist die Routine p_lc_p_lew_process_alter_success_state_ctx_lid oder ein manuelles Update auf die Task-Tabelle, welches (immer für eine Ganze CTX_ID !!!)
den status auf "waiting_for" setzt.

ctx_lid:            CONTEXT_LOAD_ID für den der Dispatcher laden möchte (sofern durch Stager freigegeben)
ctx_area_cds:       Kommaseparierte Liste von CONTEXT_AREA_CODES für die angegebene CONTEXT_LOAD_ID des parametrisierten Hierarchielevels (used_area_grp_type) und
                    bei Hierarchielevel=CLUSTER des CLustertypes (used_cluster_type)
                    OHNE EinSchluss der Codes in Hochkommata!!!
used_area_grp_type: Für die Übersetzung gewählter AREA_TYPE (= Level der Areale) [COUNTRY,CLUSTER,ALL]
used_cluster_type:  Wird in "used_area_grp_type" das Level CLUSTER verwendet, so muss bedacht werden, daß es verschiedene parallel
                        existente Clusterungen von Ländern gibt. Daher muss zusätzlich spezifiziert werden,
                        welche davon herangezogen werden soll - aktuell [SAP, POS]
                    Wird in "used_area_grp_type" das Level COUNTRY oder ALL verwendet, gibt es nur den CLUSTER-Type [-]
                        - also naturgemäß keine Unterscheidung
set_success_state_to: Ziel-Success-Status (i.a. "raw") setzt den success-status künstlich auf den übergebenen Wert

(c) Infomotion GmbH 20200225 Jens Thole
*********************************************************************************************************************************************/

var REAL_CLUSTER_TYPE;

{ REAL_CLUSTER_TYPE =USED_CLUSTER_TYPE}
//--Sicherheitshalber wird ausgeschlossen, dass der Cluster-Type für die Level COUNTRY und ALL falsch gesetzt werden kann:

{if (USED_AREA_GRP_TYPE != "CLUSTER") REAL_CLUSTER_TYPE = '-'}
try{
    //BUILD STATEMENT_1
  var sql_command = `UPDATE p_lew_process.t_lc_prtcl_context_tasks
	SET success_state= ?
	WHERE context_load_id = ?
    AND context_country_cd in (SELECT country_cd
	FROM p_lew_process.v_etl_context_orga_area
	INNER JOIN (SELECT ','|| ? ||',' arealist) cl
	ON arealist like '%,'||area_cd||',%'
	WHERE area_grp_type= ?
	AND cluster_type   = ?)
	

`;

      //RUN STATEMENT_1                               
        var stmt = snowflake.createStatement(
        {
        sqlText: sql_command,
        binds: [SET_SUCCESS_STATE_TO,CTX_LID, CTX_AREA_CDS, USED_AREA_GRP_TYPE, REAL_CLUSTER_TYPE]
        }
        );
        var res = stmt.execute();
}
catch (err) {
        return + "Failed: " + err;   // Return a success/error indicator.
        }
$$
;