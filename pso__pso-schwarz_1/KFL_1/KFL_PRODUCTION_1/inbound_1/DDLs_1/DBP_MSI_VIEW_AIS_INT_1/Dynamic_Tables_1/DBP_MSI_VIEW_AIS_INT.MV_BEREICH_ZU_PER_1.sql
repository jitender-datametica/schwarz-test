CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_BEREICH_ZU_PER_1
(
   ber_id
,mandant_id
,arthiertyp_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.wg_hierarchie_mutter_id AS ber_id,
   v01.mandant_id,
   v01.arthiertyp_id
   FROM dbp_view.v_wg_hierarchie_zu_per_1 v01

   WHERE v01.arthiertyp_id = 10
   AND v01.wg_hierarchie_ebene_id = 2
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;