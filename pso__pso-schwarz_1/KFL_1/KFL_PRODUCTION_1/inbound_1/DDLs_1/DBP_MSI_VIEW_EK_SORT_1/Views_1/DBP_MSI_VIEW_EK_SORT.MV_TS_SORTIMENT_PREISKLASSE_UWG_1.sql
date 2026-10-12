CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_TS_SORTIMENT_PREISKLASSE_UWG_1
(
mandant_id
,arthiertyp_id
,kl_owg_id
,kl_uwg_id
,wrg_id
,preislage_1
,preislage_2
,preislage_3
,preislage_4
,preislage_5
,preislage_6
,preislage_7
,preislage_8
,preislage_9
,preislage_10
)
AS


   SELECT
   mandant_id, arthiertyp_id, wg_id AS kl_owg_id, wug_id AS kl_uwg_id, wrg_id, preislage_1, preislage_2, preislage_3, preislage_4, preislage_5, preislage_6, preislage_7, preislage_8, preislage_9, preislage_10

   FROM dbp_view.v_ts_sortiment_preisklasse_wug_1;