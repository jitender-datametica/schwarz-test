CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_AUTODISPO_DIF (MANDANT_ID_KUNDE FLOAT, WUP_ID_KUNDE FLOAT, NB_ID_KUNDE FLOAT, MANDANT_ID_VZ FLOAT, WUP_ID_VZ FLOAT, NB_ID_VZ FLOAT, FRISCHE_MANAGER_ID FLOAT, ART_ID FLOAT, VS_ID FLOAT, VKL_ID FLOAT, WG_ID FLOAT, ART_GRUPPE_ID VARCHAR(16777216), DAT_VON VARCHAR(16777216), DAT_BIS VARCHAR(16777216), SA_AF_FG FLOAT, ART_CLUSTER_ID FLOAT, WUP_CLUSTER_ID FLOAT, WERBEGRUPPE_FLEISCH VARCHAR(16777216), DIF_FUNKTION_ID VARCHAR(16777216), DIF_TYP_ID FLOAT, MENGE_EINH_ID VARCHAR(16777216), DIF_STATUS_ID FLOAT, DIF_WERT FLOAT, DIF_KOMMENTAR VARCHAR(16777216))
-- 23.09.2020, AP0068964, SPEC0084285, srom0404, Neuanlage
-- 02.11.2020, AP0068964, SPEC0084285, nwag2310, Änderung UPDATE-Key, nach der Anlage soll nur noch der Status geändert werden können
-- 11.03.2021, AP0084960, SPEC0104182 - Fleisch Autodispo Massenpflege Mehrfachselektion (art_cluster_id, wup_cluster_id)
-- 20.04.2021, AP0084960, SPEC0104182, nwag2310, NULL-handling art_cluster_id, wup_cluster_id
-- 28.04.2021, AP0084960, SPEC0104182, srom0404, added werbegruppe_fleisch
-- 07.05.2021, AP0084960, SPEC0104182, nwag2310, place NULL into sharepoint-upload columns
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$

 	var sql_stmt = `MERGE INTO DBP_DATA.ts_autodispo_dif as target
                  USING (
                     SELECT  ? AS MANDANT_ID_KUNDE
                            ,? AS WUP_ID_KUNDE
                            ,? AS NB_ID_KUNDE
                            ,? AS MANDANT_ID_VZ
                            ,? AS WUP_ID_VZ
                            ,? AS NB_ID_VZ
                            ,? AS FRISCHE_MANAGER_ID
                            ,? AS ART_ID
                            ,? AS VS_ID
                            ,? AS VKL_ID
                            ,? AS WG_ID
                            ,? AS ART_GRUPPE_ID
                            ,? AS DAT_VON
                            ,? AS DAT_BIS
                            ,? AS SA_AF_FG
                            ,? AS ART_CLUSTER_ID
                            ,? AS WUP_CLUSTER_ID
                            ,? AS WERBEGRUPPE_FLEISCH
                            ,? AS DIF_FUNKTION_ID
                            ,? AS DIF_TYP_ID
                            ,? AS MENGE_EINH_ID
                            ,? AS DIF_STATUS_ID
                            ,? AS DIF_WERT
                            ,REGEXP_REPLACE(?,'\n|^[:ascii:]|\r','') AS DIF_KOMMENTAR
                  ) AS source
                      ON target.mandant_id_kunde    = source.mandant_id_kunde
                     AND target.wup_id_kunde        = source.wup_id_kunde
                     AND target.nb_id_kunde         = source.nb_id_kunde
                     AND target.mandant_id_vz       = source.mandant_id_vz
                     AND target.wup_id_vz           = source.wup_id_vz
                     AND target.nb_id_vz            = source.nb_id_vz
                     AND target.frische_manager_id  = source.frische_manager_id
                     AND target.art_id              = source.art_id           
                     AND target.vs_id               = source.vs_id
                     AND target.vkl_id              = source.vkl_id
                     AND target.wg_id               = source.wg_id
                     AND target.art_gruppe_id       = source.art_gruppe_id
                     AND target.dat_von             = source.dat_von
                     AND target.dat_bis             = source.dat_bis
                     AND target.sa_af_fg            = source.sa_af_fg
                     AND target.art_cluster_id      = COALESCE(source.art_cluster_id, -1)
                     AND target.wup_cluster_id      = COALESCE(source.wup_cluster_id, -1)
                     AND target.dif_funktion_id     = source.dif_funktion_id
                     AND target.dif_typ_id          = source.dif_typ_id
                     AND target.menge_einh_id       = source.menge_einh_id
                     -- AND target.dif_status_id       = source.dif_status_id
                     AND target.dif_wert            = source.dif_wert 
                     AND target.dif_kommentar       = source.dif_kommentar
                     AND target.werbegruppe_fleisch = COALESCE(source.werbegruppe_fleisch, '-1')
                  WHEN MATCHED THEN
                     UPDATE SET target.dif_status_id = source.dif_status_id
                  WHEN NOT MATCHED THEN 
                     INSERT 
                        (mandant_id_kunde
                        ,wup_id_kunde
                        ,nb_id_kunde
                        ,mandant_id_vz
                        ,wup_id_vz
                        ,nb_id_vz
                        ,frische_manager_id
                        ,art_id
                        ,vs_id
                        ,vkl_id
                        ,wg_id
                        ,art_gruppe_id
                        ,dat_von
                        ,dat_bis
                        ,sa_af_fg
                        ,art_cluster_id
                        ,wup_cluster_id
                        ,dif_funktion_id
                        ,dif_typ_id
                        ,menge_einh_id
                        ,dif_status_id
                        ,dif_wert
                        ,dif_kommentar
                        ,dif_timestamp
                        ,werbegruppe_fleisch
                        ,dateiname
                        ,dat_upload)
                     VALUES
                        (source.mandant_id_kunde
                        ,source.wup_id_kunde
                        ,source.nb_id_kunde
                        ,source.mandant_id_vz
                        ,source.wup_id_vz
                        ,source.nb_id_vz
                        ,source.frische_manager_id
                        ,source.art_id
                        ,source.vs_id
                        ,source.vkl_id
                        ,source.wg_id
                        ,source.art_gruppe_id
                        ,source.dat_von
                        ,source.dat_bis
                        ,source.sa_af_fg                        
                        ,source.art_cluster_id
                        ,source.wup_cluster_id
                        ,source.dif_funktion_id
                        ,source.dif_typ_id
                        ,source.menge_einh_id
                        ,source.dif_status_id
                        ,source.dif_wert
                        ,source.dif_kommentar
                        ,CURRENT_TIMESTAMP()
                        ,source.werbegruppe_fleisch
                        ,NULL
                        ,NULL)
                        `;
sql_stmt = sql_stmt.replace(/undefined/g, "NULL");

snowflake.createStatement({
	   sqlText : sql_stmt,
	   binds:[MANDANT_ID_KUNDE, WUP_ID_KUNDE, NB_ID_KUNDE, MANDANT_ID_VZ, WUP_ID_VZ, NB_ID_VZ, FRISCHE_MANAGER_ID, ART_ID, VS_ID, 
              VKL_ID, WG_ID, ART_GRUPPE_ID, DAT_VON, DAT_BIS, SA_AF_FG, ART_CLUSTER_ID, WUP_CLUSTER_ID, WERBEGRUPPE_FLEISCH,  
              DIF_FUNKTION_ID, DIF_TYP_ID, MENGE_EINH_ID, DIF_STATUS_ID, DIF_WERT, DIF_KOMMENTAR]
	}).execute();

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;
