CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_MARKT_TYP
(
ginfo_markt_typ
,ginfo_markt_typ_bez
)
AS
   SELECT
   ginfo_markt_typ, ginfo_markt_typ_bez
   FROM dbp_view.v_l_ginfo_markt_typ
;