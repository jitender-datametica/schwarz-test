CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_JAHR_GJ_VERSATZ_1
--  akt_gj_versatz hat einen Monat_1 Versatz, schaltet also erst am 01.04. statt 01.03. um
-- (z.B. im Maerz 2012 wird fuer akt_gj = 0 noch 2011 ausgegeben, ab April dann 2012)
(
gj
, akt_gj
, akt_gj_komplett
, akt_gj_versatz
)
AS
   SELECT
   gj, akt_gj, akt_gj_komplett, akt_gj + maerz_fg as akt_gj_versatz

   FROM dbp_view.v_jahr_gj_1
   CROSS JOIN
   (select
   case when mo_gj = 1 then 1 else 0 end maerz_fg
   from dbp_view.v_monat_1
   where akt_mo=0) m;