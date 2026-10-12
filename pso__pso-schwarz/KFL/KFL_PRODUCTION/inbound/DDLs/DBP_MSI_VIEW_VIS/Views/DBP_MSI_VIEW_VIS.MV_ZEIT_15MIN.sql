CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZEIT_15MIN (
	ZEIT_STUNDE,
	ZEIT_15MIN,
	ZEIT_15MIN_BEZ,
	ZEIT_30MIN
) AS  
/* 
   LOOKUP: Zeit - 15min Intervall
   2023-05-24 ssch0611 : Bugfix 30mins
   2023-05-30 ssch0611 : Reihenfolge Spalten vertauscht. INC6688386
*/ 
SELECT
  zeit_stunde
, zeit_minute                              AS zeit_15min
, zeit_von || '-' || zeit_bis_15min        AS zeit_15min_bez
, (FLOOR(zeit_minute / 30) * 30)::INTEGER  AS zeit_30min
FROM dbp_view.v_zeit;