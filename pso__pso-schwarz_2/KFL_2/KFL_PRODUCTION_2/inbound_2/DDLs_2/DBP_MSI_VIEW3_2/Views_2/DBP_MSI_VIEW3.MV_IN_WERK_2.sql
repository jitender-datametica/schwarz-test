CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_WERK_2
(
mandant_id
,werk_id
,werk_nr
,werk_name
,system_id
,sako_fg
,buchungskreis_id
)
AS
   SELECT
   mandant_id, werk_id, werk_nr, werk_name, system_id, sako_fg, buchungskreis_id
   FROM dbp_view.v_in_werk_2
;