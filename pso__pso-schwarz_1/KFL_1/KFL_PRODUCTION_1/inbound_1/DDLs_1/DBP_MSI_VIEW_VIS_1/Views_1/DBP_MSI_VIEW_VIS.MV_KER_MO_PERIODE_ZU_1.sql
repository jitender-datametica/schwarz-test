CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KER_MO_PERIODE_ZU_1
(
buchungsperiode_id,
buchungsperiode_bez,
gj, ker_mo_id, kj,
-- krk_id,
-- mandant_id,
-- system_id,
kj_ker_mo_id,
kjmo,
akt_mo,
akt_gj
)
AS
   SELECT
  v01.buchungsperiode_id,
   v02.buchungsperiode_bez,
   v01.gj,
   v01.ker_mo_id,
   v01.kj,
   -- v01.krk_id,
   -- v01.mandant_id,
   -- v01.system_id,
   v01.kj_ker_mo_id,
   v01.kjmo,
   v03.akt_mo,
   v04.akt_gj
   FROM dbp_view.v_ker_mo_periode_zu_1 v01
   INNER JOIN dbp_view.v_l_buchungsperiode_1 v02
   ON v01.buchungsperiode_id=v02.buchungsperiode_id
   AND v01.krk_id=v02.krk_id
   LEFT OUTER JOIN dbp_view.v_monat_1 v03
   ON v01.kj_ker_mo_id = v03.kjmo
   join (SELECT gj, akt_gj from dbp_view.v_monat_1 group by 1,2) v04
   ON v01.gj = v04.gj
   WHERE mandant_id = 3
   and v01.buchungsperiode_id <= 13;