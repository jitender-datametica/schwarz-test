CREATE OR REPLACE PROCEDURE DBP_MACRO.M_DELETE_TS_AUTODISPO_DIF (MANDANT_ID_KUNDE FLOAT, WUP_ID_KUNDE FLOAT, NB_ID_KUNDE FLOAT, MANDANT_ID_VZ FLOAT, WUP_ID_VZ FLOAT, NB_ID_VZ FLOAT, ART_ID FLOAT, VS_ID FLOAT, VKL_ID FLOAT, WG_ID FLOAT, ART_GRUPPE_ID VARCHAR(16777216), DAT_VON VARCHAR(16777216), DAT_BIS VARCHAR(16777216), SA_AF_FG FLOAT, ART_CLUSTER_ID FLOAT, WUP_CLUSTER_ID FLOAT, WERBEGRUPPE_FLEISCH VARCHAR(16777216), DIF_FUNKTION_ID VARCHAR(16777216), DIF_TYP_ID FLOAT, MENGE_EINH_ID VARCHAR(16777216), DIF_STATUS_ID FLOAT, DELETE_FG FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS $$

 	var sql_stmt = `
     DELETE FROM dbp_data.ts_autodispo_dif
     WHERE mandant_id_kunde    = ?
       AND wup_id_kunde        = ?
       AND nb_id_kunde         = ?
       AND mandant_id_vz       = ?
       AND wup_id_vz           = ?
       AND nb_id_vz            = ?
       AND art_id              = ?
       AND vs_id               = ?
       AND vkl_id              = ?
       AND wg_id               = ?
       AND art_gruppe_id       = ?
       AND dat_von             = ?
       AND dat_bis             = ?
       AND sa_af_fg            = ?
       AND art_cluster_id      = ?
       AND wup_cluster_id      = ?
       AND werbegruppe_fleisch = ?
       AND dif_funktion_id     = ?
       AND dif_typ_id          = ?
       AND menge_einh_id       = ?
       AND dif_status_id       = ?
       AND 1                   = ?
       `;

sql_stmt = sql_stmt.replace(/undefined/g, "NULL");

snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[MANDANT_ID_KUNDE, WUP_ID_KUNDE, NB_ID_KUNDE, MANDANT_ID_VZ, WUP_ID_VZ, NB_ID_VZ, ART_ID, VS_ID, VKL_ID, WG_ID, ART_GRUPPE_ID, DAT_VON,
              DAT_BIS, SA_AF_FG, ART_CLUSTER_ID, WUP_CLUSTER_ID, WERBEGRUPPE_FLEISCH, DIF_FUNKTION_ID, DIF_TYP_ID, MENGE_EINH_ID, DIF_STATUS_ID, DELETE_FG]
	}).execute();

var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;