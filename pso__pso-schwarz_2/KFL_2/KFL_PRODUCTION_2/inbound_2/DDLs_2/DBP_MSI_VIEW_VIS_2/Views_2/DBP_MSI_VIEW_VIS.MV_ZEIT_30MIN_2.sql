CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEIT_30MIN_2(
	ZEIT_STUNDE,
	ZEIT_30MIN,
	ZEIT_30MIN_BEZ
) AS
/* 
   LOOKUP: Zeit_2 - 30min Intervall
   2023-05-16 ssch0611 : Checked
*/ 
SELECT
  zeit_stunde
, zeit_minute AS zeit_30min
, zeit_von || '-' || zeit_bis_30min   AS zeit_30min_bez
FROM dbp_view.v_zeit_2
WHERE zeit_minute IN (0,30);