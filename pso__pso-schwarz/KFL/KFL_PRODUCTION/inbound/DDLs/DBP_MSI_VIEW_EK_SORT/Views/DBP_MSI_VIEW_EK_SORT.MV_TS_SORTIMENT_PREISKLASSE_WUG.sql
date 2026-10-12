CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_TS_SORTIMENT_PREISKLASSE_WUG
AS

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, v01.wug_id, v01.wrg_id, v01.preislage_1, v01.preislage_2, v01.preislage_3, v01.preislage_4, v01.preislage_5, v01.preislage_6, v01.preislage_7, v01.preislage_8, v01.preislage_9, v01.preislage_10

   FROM dbp_view.v_ts_sortiment_preisklasse_wug v01
   JOIN dbp_view.v_mandant v02
   ON (v01.mandant_id = v02.mandant_id AND v01.wrg_id = v02.default_wrg);