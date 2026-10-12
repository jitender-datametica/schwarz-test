 CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_CROSSDOCKING_SPR_ZU
(
 mandant_id
,crossdocking_id
,spr_id
,crossdocking_bez
)
AS
  SELECT
  v01.Mandant_id
 ,v01.crossdocking_id
 ,v01.spr_id 
 ,v01.crossdocking_bez
 FROM dbp_data.crossdocking_spr_zu v01
 WHERE v01.mandant_id =1
 AND  v01.spr_id =  22;