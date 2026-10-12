CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_JAHR_GJ_1
( gj
, akt_gj
, akt_gj_komplett
)
AS
   SELECT
     gj, akt_gj, akt_gj_komplett
   FROM dbp_view.v_jahr_gj_1
   WHERE gj>2003
;