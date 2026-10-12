CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TAG
(
dat
,kjmo
,kjmo_vj
,gjmo
,gjmo_vj
,kj
,gj
,dat_vj
,akt_tag
,akt_mo
,akt_gj
,akt_kj
,mo_gj
,mo_kj)
AS
   SELECT
  dat, kjmo, kjmo_vj, gjmo, gjmo_vj, kj, gj, dat_vj, akt_tag, akt_mo, akt_gj, akt_kj, mo_gj, mo_kj
   FROM dbp_view.v_tag

   UNION ALL

   (Select distinct
   CAST(  '2099-12-31' as DATE) AS dat, CAST( 209912 as INTEGER) AS kjmo, CAST( 209812 as INTEGER) AS kjmo_vj, CAST( 209910 as INTEGER) AS gjmo, CAST( 209810 as INTEGER) AS gjmo_vj, CAST( 2099 as SMALLINT) AS kj, CAST( 2099 as SMALLINT) AS gj, CAST( '2098-12-31' as DATE) AS dat_vj, CAST(9999 as SMALLINT) AS akt_tag, CAST( 999 as SMALLINT) AS akt_mo, CAST( 999 as SMALLINT) AS akt_gj, CAST( 999 as SMALLINT) AS akt_kj, CAST( 10 as BYTEINT) AS mo_gj, CAST( 12 as BYTEINT) AS mo_kj

   from dbp_view.v_tag);