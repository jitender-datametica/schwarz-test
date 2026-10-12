-- 23.09.2020, AP0068964, SPEC0084285, srom0404, Neuanlage



-- 02.11.2020, AP0068964, SPEC0084285, nwag2310, Änderung UPDATE-Key, nach der Anlage_2 soll nur noch der Status_2 geändert werden können



-- 11.03.2021, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion (art_cluster_id, wup_cluster_id)



-- 20.04.2021, AP0084960, SPEC0104182, nwag2310, NULL-handling art_cluster_id, wup_cluster_id



-- 28.04.2021, AP0084960, SPEC0104182, srom0404, added werbegruppe_fleisch



-- 07.05.2021, AP0084960, SPEC0104182, nwag2310, place NULL into sharepoint-upload columns



CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_autodispo_dif(IN MANDANT_ID_KUNDE FLOAT64, IN WUP_ID_KUNDE FLOAT64, IN NB_ID_KUNDE FLOAT64, IN MANDANT_ID_VZ FLOAT64, IN WUP_ID_VZ FLOAT64, IN NB_ID_VZ FLOAT64, IN FRISCHE_MANAGER_ID FLOAT64, IN ART_ID FLOAT64, IN VS_ID FLOAT64, IN VKL_ID FLOAT64, IN WG_ID FLOAT64, IN ART_GRUPPE_ID STRING, IN DAT_VON STRING, IN DAT_BIS STRING, IN SA_AF_FG FLOAT64, IN ART_CLUSTER_ID FLOAT64, IN WUP_CLUSTER_ID FLOAT64, IN WERBEGRUPPE_FLEISCH STRING, IN DIF_FUNKTION_ID STRING, IN DIF_TYP_ID FLOAT64, IN MENGE_EINH_ID STRING, IN DIF_STATUS_ID FLOAT64, IN DIF_WERT FLOAT64, IN DIF_KOMMENTAR STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
SET sql_stmt  =  '''MERGE INTO dbp_data.ts_autodispo_dif_2 AS TARGET USING (SELECT @MANDANT_ID_KUNDE AS mandant_id_kunde,   
@WUP_ID_KUNDE AS wup_id_kunde,   
@NB_ID_KUNDE AS nb_id_kunde,   
@MANDANT_ID_VZ AS mandant_id_vz,   
@WUP_ID_VZ AS wup_id_vz,   
@NB_ID_VZ AS nb_id_vz,   
@FRISCHE_MANAGER_ID AS frische_manager_id,   
@ART_ID AS art_id,   
@VS_ID AS vs_id,   
@VKL_ID AS vkl_id,   
@WG_ID AS wg_id,   
@ART_GRUPPE_ID AS art_gruppe_id,   
@DAT_VON AS dat_von,   
@DAT_BIS AS dat_bis,   
@SA_AF_FG AS sa_af_fg,   
@ART_CLUSTER_ID AS art_cluster_id,   
@WUP_CLUSTER_ID AS wup_cluster_id,   
@WERBEGRUPPE_FLEISCH AS werbegruppe_fleisch,   
@DIF_FUNKTION_ID AS dif_funktion_id,   
@DIF_TYP_ID AS dif_typ_id,   
@MENGE_EINH_ID AS menge_einh_id,   
@DIF_STATUS_ID AS dif_status_id,   
@DIF_WERT AS dif_wert,   
REGEXP_REPLACE(REGEXP_REPLACE(@DIF_KOMMENTAR, " |^[ascii:]| ", ""), " |^[ascii:]| ", "") AS dif_kommentar) AS source  
ON TARGET.mandant_id_kunde = source.mandant_id_kunde 
AND TARGET.wup_id_kunde = source.wup_id_kunde 
AND TARGET.nb_id_kunde = source.nb_id_kunde 
AND TARGET.mandant_id_vz = source.mandant_id_vz 
AND TARGET.wup_id_vz = source.wup_id_vz 
AND TARGET.nb_id_vz = source.nb_id_vz 
AND TARGET.frische_manager_id = source.frische_manager_id                    
AND TARGET.art_id = source.art_id 
AND TARGET.vs_id = source.vs_id 
AND TARGET.vkl_id = source.vkl_id              
AND TARGET.wg_id = source.wg_id 
AND TARGET.art_gruppe_id = source.art_gruppe_id 
AND TARGET.dat_von = CAST(source.dat_von AS DATE)              
AND TARGET.dat_bis = CAST(source.dat_bis AS DATE) 
AND TARGET.sa_af_fg = source.sa_af_fg 
AND TARGET.art_cluster_id = COALESCE(source.art_cluster_id, -1) 
AND TARGET.wup_cluster_id = COALESCE(source.wup_cluster_id, -1) 
AND TARGET.dif_funktion_id = source.dif_funktion_id 
AND TARGET.dif_typ_id = source.dif_typ_id 
AND TARGET.menge_einh_id = source.menge_einh_id 
AND TARGET.dif_wert = source.dif_wert 
AND TARGET.dif_kommentar = source.dif_kommentar 
AND TARGET.werbegruppe_fleisch = COALESCE(source.werbegruppe_fleisch, "-1") WHEN MATCHED THEN 
UPDATE SET  dif_status_id = CAST(source.dif_status_id AS INTEGER) 
WHEN NOT MATCHED THEN 
INSERT (mandant_id_kunde, 
wup_id_kunde, 
nb_id_kunde, 
mandant_id_vz, 
wup_id_vz, 
nb_id_vz,  
frische_manager_id, 
art_id, 
vs_id, 
vkl_id, 
wg_id, 
art_gruppe_id, 
dat_von, 
dat_bis, 
sa_af_fg, 
dif_funktion_id,  
dif_typ_id, 
menge_einh_id, 
dif_status_id, 
dif_wert, 
dif_kommentar, 
dif_timestamp, 
art_cluster_id, 
wup_cluster_id,  
werbegruppe_fleisch, 
dateiname, 
dat_upload) VALUES(CAST(source.mandant_id_kunde AS INTEGER), 
CAST(source.wup_id_kunde AS INTEGER)  , 
CAST(source.nb_id_kunde AS INTEGER), 
CAST(source.mandant_id_vz AS INTEGER), 
CAST(source.wup_id_vz AS INTEGER), 
CAST(source.nb_id_vz AS INTEGER)  , 
CAST(source.frische_manager_id AS INTEGER), 
CAST(source.art_id AS INTEGER), 
CAST(source.vs_id AS INTEGER), 
CAST(source.vkl_id AS INTEGER)  , 
CAST(source.wg_id AS INTEGER), 
source.art_gruppe_id, 
CAST(source.dat_von AS DATE), 
CAST(source.dat_bis AS DATE), 
CAST(source.sa_af_fg AS INTEGER)  , 
source.dif_funktion_id, 
CAST(source.dif_typ_id AS INTEGER), 
source.menge_einh_id, 
CAST(source.dif_status_id AS INTEGER)  , 
CAST(ROUND(CAST(source.dif_wert AS BIGNUMERIC), 0) AS NUMERIC), 
source.dif_kommentar, 
CAST(CURRENT_TIMESTAMP() AS DATETIME), 
CAST(source.art_cluster_id AS INTEGER)  , 
CAST(source.wup_cluster_id AS INTEGER), 
source.werbegruppe_fleisch, 
CAST(NULL AS STRING),
CAST(NULL AS DATE)) ''';

SET sql_stmt  =  REGEXP_REPLACE(sql_stmt, 'undefined', 'NULL');


EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID_KUNDE AS MANDANT_ID_KUNDE,  WUP_ID_KUNDE AS WUP_ID_KUNDE,  NB_ID_KUNDE AS NB_ID_KUNDE,  MANDANT_ID_VZ AS MANDANT_ID_VZ,  WUP_ID_VZ AS WUP_ID_VZ,  NB_ID_VZ AS NB_ID_VZ,  FRISCHE_MANAGER_ID AS FRISCHE_MANAGER_ID,  ART_ID AS ART_ID,  VS_ID AS VS_ID,  VKL_ID AS VKL_ID,  WG_ID AS WG_ID,  ART_GRUPPE_ID AS ART_GRUPPE_ID,  DAT_VON AS DAT_VON,  DAT_BIS AS DAT_BIS,  SA_AF_FG AS SA_AF_FG,  ART_CLUSTER_ID AS ART_CLUSTER_ID,  WUP_CLUSTER_ID AS WUP_CLUSTER_ID,  WERBEGRUPPE_FLEISCH AS WERBEGRUPPE_FLEISCH,  DIF_FUNKTION_ID AS DIF_FUNKTION_ID,  DIF_TYP_ID AS DIF_TYP_ID,  MENGE_EINH_ID AS MENGE_EINH_ID,  DIF_STATUS_ID AS DIF_STATUS_ID,  DIF_WERT AS DIF_WERT,  DIF_KOMMENTAR AS DIF_KOMMENTAR;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
