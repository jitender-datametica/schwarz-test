CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_attribut_zu_1 (mandant_id, angebot_nr,
masterbonus_fg, mood_fg, gondelkopf_fg, am_faktor_fg, masterbonus_fg_txt, mood_fg_txt, gondelkopf_fg_txt,
am_faktor_fg_txt, menge_aller_filialen, masterbonus_fg_bez, mood_fg_bez, gondelkopf_fg_bez, am_faktor_fg_bez) AS SELECT
 V01.mandant_id,
 V01.angebot_nr,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 41
   THEN 'X'
   ELSE ''
   END) AS masterbonus_fg,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 47
   THEN 'X'
   ELSE ''
   END) AS mood_fg,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 49
   THEN 'X'
   ELSE ''
   END) AS gondelkopf_fg,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 52
   THEN 'X'
   ELSE ''
   END) AS am_faktor_fg,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 41
   THEN V01.angebot_attribut_txt
   ELSE ''
   END) AS masterbonus_fg_txt,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 47
   THEN V01.angebot_attribut_txt
   ELSE ''
   END) AS mood_fg_txt,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 49
   THEN V01.angebot_attribut_txt
   ELSE ''
   END) AS gondelkopf_fg_txt,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 52
   THEN V01.angebot_attribut_txt
   ELSE ''
   END) AS am_faktor_fg_txt,
 SUM(CASE
   WHEN V01.angebot_attribut_id = 44
   THEN 1
   ELSE 0
   END) AS menge_aller_filialen,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 41
   THEN V02.angebot_attribut_bez
   ELSE ''
   END) AS masterbonus_fg_bez,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 47
   THEN V02.angebot_attribut_bez
   ELSE ''
   END) AS mood_fg_bez,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 49
   THEN V02.angebot_attribut_bez
   ELSE ''
   END) AS gondelkopf_fg_bez,
 MAX(CASE
   WHEN V01.angebot_attribut_id = 52
   THEN V02.angebot_attribut_bez
   ELSE ''
   END) AS am_faktor_fg_bez
FROM kfl_production_dbp_data.angebot_attribut_zu_1 AS V01
 INNER JOIN kfl_production_dbp_data.angebot_attribut_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.angebot_attribut_id
     = V02.angebot_attribut_id AND V02.spr_id = 22
GROUP BY V01.mandant_id,
 V01.angebot_nr;