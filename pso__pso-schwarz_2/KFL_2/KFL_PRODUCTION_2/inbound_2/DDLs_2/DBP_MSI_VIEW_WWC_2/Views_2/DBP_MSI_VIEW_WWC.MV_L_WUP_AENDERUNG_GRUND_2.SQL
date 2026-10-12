 CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_WUP_AENDERUNG_GRUND_2 
(
 mandant_id
,wup_id
,wup_aenderung_grund_id
,wup_aenderung_grund_bez
)
AS
--19.08.2024, SPEC0263068, prescherad, Neueanlage für Filialumgliederung, Änderungsgründe für Mandant_2 DE
   SELECT 
   '1' AS mandant_id, 
   v01.wup_id, 
   v02.wup_aenderung_grund_id,
   v02.wup_aenderung_grund_bez
   
   FROM dbp_view.v_wup_2 v01
   INNER JOIN dbp_view.v_wup_aenderung_grund_spr_zu_2 v02
   ON v01.wup_aenderung_grund_id=v02.wup_aenderung_grund_id
   WHERE v02.spr_id = 22;