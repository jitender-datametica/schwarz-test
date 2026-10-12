CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_JAHR_KJ_1
AS
   SELECT
   v01.kj, v01.akt_kj, v01.akt_kj_komplett, v01.kj -1 AS prev_kj

   FROM dbp_view.v_jahr_kj_1 v01

   WHERE v01.akt_kj BETWEEN -11 AND 2;