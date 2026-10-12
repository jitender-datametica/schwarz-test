CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_KUMULATION_GJMO
(
gj
,mo_gj
,gjmo
,gjmo_kum
)
AS
   SELECT
   a.gj,
   a.mo_gj,
   a.gjmo,
   b.gjmo gjmo_kum
   FROM dbp_view.v_monat a
   INNER JOIN dbp_view.v_monat b
   ON  a.gjmo >= b.gjmo
   AND a.gj = b.gj ;