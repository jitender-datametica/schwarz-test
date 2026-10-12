CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_IN_AKTION_FG_SPR_ZU_2

(
in_aktion_fg
,in_aktion_fg_bez
)
AS
   SELECT
   mandant_id - 1,
   CASE WHEN mandant_id = 1 THEN 'Nein' ELSE 'Ja' END
   FROM dbp_view.v_mandant_2
   WHERE mandant_id <> 1;