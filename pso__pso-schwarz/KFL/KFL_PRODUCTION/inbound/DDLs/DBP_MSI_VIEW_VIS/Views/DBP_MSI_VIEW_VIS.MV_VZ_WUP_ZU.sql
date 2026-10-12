CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VZ_WUP_ZU
AS
   -- ZUORDNUNG Verteilzentrum - Filiale
   -- BASIS: vz_wg_wup_zu_per - Blackberry-Reporting
   -- 2011KW18 Initial

   SELECT
   v01.mandant_id, v01.nb_id, v01.wup_id, v01.wup_standort, COALESCE(v03.vz_wup_id, 0)    AS vz_wup_id, COALESCE(v03.vz_prio_id, 0)   AS vz_prio_id, COALESCE(v03.kreistyp_id, '') AS vz_kreistyp_id

   FROM (
   SELECT
   mandant_id, nb_id, wup_id, wup_standort
   FROM dbp_view.v_wup

   WHERE (nb_id = 0 OR wup_id = 0)
   AND dat_eroeffnung > '1900-01-01'
   AND (mandant_id, wup_id) NOT IN
   ( -- Umzugsfilialen analog mv_wup
   SELECT mandant_id, wup_id_alt AS wup_id
   FROM dbp_view.v_wup
   WHERE wup_id_alt > 0
   AND dat_von > '2010-03-01' -- ab GJ2010
   AND dat_von < CURRENT_DATE
   )
   ) v01
   LEFT JOIN (
   SELECT
   mandant_id, nb_id, wup_id, vz_wup_id, vz_prio_id, kreistyp_id
   FROM dbp_view.v_vz_wg_wup_zu_per

   WHERE dat_bis = '9999-12-31'
   AND arthiertyp_id = -1
   AND wg_hierarchie_ebene_id = -1
   AND wg_hierarchie_id = -1

   GROUP BY
   mandant_id
   , nb_id
   , wup_id
   , vz_wup_id
   , vz_prio_id
   , kreistyp_id
   ) v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id;