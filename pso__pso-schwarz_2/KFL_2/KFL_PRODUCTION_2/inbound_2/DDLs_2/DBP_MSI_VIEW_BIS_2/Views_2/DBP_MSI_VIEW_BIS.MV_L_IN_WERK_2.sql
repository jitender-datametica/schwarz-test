CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_WERK_2
-- 03.12.2012 Shoger initial
( werk_id
,mandant_id
,werk_nr
,werk_name
,sako_fg
,buchungskreis_id
)
AS
   SELECT werk_id,
   mandant_id,
   werk_nr,
   werk_name,
   sako_fg,
   buchungskreis_id
   FROM dbp_view.v_in_werk_2
   WHERE sako_fg =1;