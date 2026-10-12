CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEIT_1H(
	ZEIT_STUNDE,
	ZEIT_1_H_BEZ
) AS 
/* 
   LOOKUP: Zeit - 1h Intervall
   2023-05-16 ssch0611 : Checked
*/ 
SELECT
  zeit_stunde
, zeit_von || '-' || zeit_bis_1_h AS zeit_1_h_bez
FROM dbp_view.v_zeit
WHERE zeit_minute = 0;
