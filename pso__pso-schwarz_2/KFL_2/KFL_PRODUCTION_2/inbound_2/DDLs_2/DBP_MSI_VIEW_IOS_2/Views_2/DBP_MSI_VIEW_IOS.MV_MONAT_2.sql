CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MONAT_2
(
kjmo
,gjmo
,kj
,gj
,akt_mo
,akt_gj
,akt_kj
,mo_gj
,mo_kj
)
AS
   SELECT
  kjmo, gjmo, kj, gj, akt_mo, akt_gj, akt_kj, mo_gj, mo_kj

   FROM dbp_view.v_monat_2

   UNION ALL

   (SELECT DISTINCT
   CAST( 209912 as INTEGER) AS kjmo, CAST( 209910 as INTEGER) AS gjmo, CAST( 2099 as SMALLINT) AS kj, CAST( 2099 as SMALLINT) AS gj, CAST( 999 as SMALLINT) AS akt_mo, CAST( 99 as SMALLINT) AS akt_gj, CAST( 99 as SMALLINT) AS akt_kj, CAST( 10 as SMALLINT) AS mo_gj, CAST( 12 as SMALLINT) AS mo_kj
   FROM dbp_view.v_monat_2);