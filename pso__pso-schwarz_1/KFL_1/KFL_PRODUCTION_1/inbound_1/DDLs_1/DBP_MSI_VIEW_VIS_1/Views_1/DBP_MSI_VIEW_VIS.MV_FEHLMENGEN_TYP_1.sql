CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FEHLMENGEN_TYP_1
AS
   -- LOOKUP Fehlemengen zur Steuerung von Metriken
   -- (Generiert aus Tag_1-Tabelle)
   -- 2011KW46 Initial

   SELECT
   --dat - date::BYTEINT AS typ_fg,
   (dat - current_date)::BYTEINT AS typ_fg,
   CASE
   WHEN typ_fg = 0 THEN 'Fehlmengen'
   WHEN typ_fg = 1 THEN 'Nullbestand'
   WHEN typ_fg = 2 THEN 'Minusbestand'
   ELSE '' END::VARCHAR(20) AS typ_bez
   FROM dbp_view.v_tag_1
   --WHERE dat between date and date + 2;
   WHERE dat between CURRENT_DATE() and DATEADD(day,2,CURRENT_DATE);