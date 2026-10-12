CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cos_bonuspunkte_blockiert_1 (crm_konto_id
OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos.'), dat_bonuspunkte_blockiert_bis
OPTIONS(description='Datum bis wann die Bonuspunkte blockiert sind. Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.'),
dat_verfall_bonuspunkte_blockiert OPTIONS(description='Datum, an dem die gesammelten Bonuspunkte verfallen werden.'),
mandant_id OPTIONS(description='KFL-Land_1 des Kundenkontos, das an Loyalty-Programms teilnimmt.'),
anz_bonuspunkte_blockiert OPTIONS(description='Die gesamte anzahl der blockierten Bonuspunkten auf das Konto.'),
datzeit_update
OPTIONS(description='Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT, DIE ERWORBENEN BONUSPUNKTE BEI KUNDEN, DIE BIS ZU EINEM DATUM BLOCKIERT SIND UND SPÄTER GUTGESCHRIEBEN WERDEN.,Z.B. NACH ABLAUF DER RÜCKGABEFRIST.`)
AS SELECT crm_konto_id,
 dat_bonuspunkte_blockiert_bis,
 dat_verfall_bonuspunkte_blockiert,
 mandant_id,
 anz_bonuspunkte_blockiert,
 datzeit_update
FROM kfl_production_dbp_data.cos_bonuspunkte_blockiert_1;