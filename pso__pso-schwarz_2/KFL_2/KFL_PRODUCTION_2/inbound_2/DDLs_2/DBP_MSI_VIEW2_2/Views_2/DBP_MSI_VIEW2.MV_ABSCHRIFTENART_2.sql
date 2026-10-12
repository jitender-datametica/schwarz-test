CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ABSCHRIFTENART_2

-- Anfo 585178 Ausschluss neue Abschriftenart 0090, da neue View / sschuecke
-- AP0034888, SPEC0139670 - Lagerbewegungen added

(
abschriftenart_id,
abschriftenart_bez,
mandant_id,
spr_id
)
AS
   SELECT
   abschriftart_id,
   /* SPEC0252053 Änderung BEZ für abschriftart_id 27 / sschuecke 23.05.2024 */
   CASE WHEN abschriftart_id = 27 THEN 'Preisabschr. Kühlschäden, Betriebsunt.' ELSE abschriftart_bez END AS abschriftart_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_abschriftart_spr_zu_2
   WHERE mandant_id=1
   AND abschriftart_id NOT IN (90, 241, 242)

   UNION ALL
   
   SELECT DISTINCT
   CASE 
   WHEN lager_bewart_id IN ('V10','V11','W10','W11') THEN 210
   WHEN lager_bewart_id IN ('V25','V26','W25','W26') THEN 211
   WHEN lager_bewart_id IN ('V12','W12') THEN 212
   WHEN lager_bewart_id IN ('V13','W13') THEN 213
   WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') THEN 240
   WHEN lager_bewart_id IN ('V27','V28','W27','W28') THEN 241
   WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') THEN 242
   END
   ,CASE 
   WHEN lager_bewart_id IN ('V10','V11','W10','W11') THEN 'RLZ'
   WHEN lager_bewart_id IN ('V25','V26','W25','W26') THEN 'RLZ Spenden'
   WHEN lager_bewart_id IN ('V12','W12') THEN 'Artikelumbuchung O&G'
   WHEN lager_bewart_id IN ('V13','W13') THEN 'Textilvermarktung'
   WHEN lager_bewart_id IN ('V50','V51','V52','V53','W50','W51','W52','W53') THEN 'Bewirtung Zentrale'
   WHEN lager_bewart_id IN ('V27','V28','W27','W28') THEN 'Entnahme Zentrale QS / EK / Externe'
   WHEN lager_bewart_id IN ('V54','V55','V56','V57','W54','W55','W56','W57') THEN 'Gewinne / Kundenwerbegeschenke / Sponsoring'
   END
   ,mandant_id
   ,22 AS spr_id
   FROM dbp_view.v_l_lager_bewart_2
   WHERE lager_bewart_id IN ('V11','V12','V13','V10','W11','W12','W13','W10','V25','V26','V27','V28','W25','W26','W27','W28',
                             'V50','V51','V52','V53','W50','W51','W52','W53','V54','V55','V56','V57','W54','W55','W56','W57')
   AND mandant_id = 1;