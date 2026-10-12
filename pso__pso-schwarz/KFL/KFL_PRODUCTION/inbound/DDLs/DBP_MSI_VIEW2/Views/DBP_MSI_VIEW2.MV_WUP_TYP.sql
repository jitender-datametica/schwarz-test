CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUP_TYP
(
wup_typ_id
,wup_typ_bez
)
AS
   SELECT
  wup_typ_id, wup_typ_bez

   FROM dbp_view.v_wup_typ
   -- 20100330 Filterung der IWT Betriebe
   WHERE wup_typ_id <> 3;