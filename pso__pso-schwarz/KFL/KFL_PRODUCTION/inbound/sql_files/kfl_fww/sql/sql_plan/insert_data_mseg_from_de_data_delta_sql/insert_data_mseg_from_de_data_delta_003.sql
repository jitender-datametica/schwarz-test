--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbew
(
  mandant_id
, lagerbew_beleg_id
, kj
, vorgangsart_id
, dat_buch
, beleg_user_name
, ref_lagerbew_beleg_id
, dat_beleg
, dat_erfasst
, belegart_id
, belegkopftext
, waren_begl_schein_id
, system_id
, ref_lagerbew_beleg_id_num
, lief_gp_id
, zeit_erfasst
, transaktion_code
, td_insert
, td_update
)
SELECT
  mandant_id
, lagerbew_beleg_id
, kj
, vorgangsart_id
, dat_buch
, beleg_user_name
, ref_lagerbew_beleg_id
, dat_beleg
, dat_erfasst
, belegart_id
, belegkopftext
, waren_begl_schein_id
, system_id
, ref_lagerbew_beleg_id_num
, lief_gp_id
, zeit_erfasst
, transaktion_code
,CURRENT_TIMESTAMP
,CURRENT_TIMESTAMP

FROM DBP_DATA.lagerbew_delta
WHERE mandant_id = 1
;



--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbew_det
(
  mandant_id
, lagerbew_beleg_id
, lagerbew_beleg_pos_id
, kj
, lager_bewart_id
, art_id
, grund_id
, wup_id
, nb_id
, auto_fg
, lagerort_id
, gp_id
, soll_haben_kz
, wrg_id
, best_beleg_id
, best_beleg_pos_id
, betrag_lagerbew
, betrag_verkauf
, betrag_verkauf_ist
, menge_lagerbew_bme
, einkaufsorganisation_id
, erfsngs_menge_einh_id
, lagerplatz_id
, kunde_id
, mandant_id_kunde
, menge_lagerbew_kolli
, menge_lagerbew_palette
, menge_lieferschein
, menge_lief
, menge_erf
, empfaenger_id
, mandant_id_empfaenger
, dat_buch
, lagerbew_beleg_storno_id
, lagerbew_beleg_pos_storno_id
, lagerbew_beleg_storno_kj
, betrag_vk_netto
, betrag_vk_netto_vz
, system_id
, betrag_belegfluss_wg_art
, bw_vorgang_id
, betrag_verkauf_ist_netto
, td_insert
, td_update
)
SELECT
  mandant_id
, lagerbew_beleg_id
, lagerbew_beleg_pos_id
, kj
, lager_bewart_id
, art_id
, grund_id
, wup_id
, nb_id
, auto_fg
, lagerort_id
, gp_id
, soll_haben_kz
, wrg_id
, best_beleg_id
, best_beleg_pos_id
, betrag_lagerbew
, betrag_verkauf
, betrag_verkauf_ist
, menge_lagerbew_bme
, einkaufsorganisation_id
, erfsngs_menge_einh_id
, lagerplatz_id
, kunde_id
, mandant_id_kunde
, menge_lagerbew_kolli
, menge_lagerbew_palette
, menge_lieferschein
, menge_lief
, menge_erf
, empfaenger_id
, mandant_id_empfaenger
, dat_buch
, lagerbew_beleg_storno_id
, lagerbew_beleg_pos_storno_id
, lagerbew_beleg_storno_kj
, betrag_vk_netto
, betrag_vk_netto_vz
, system_id
, betrag_belegfluss_wg_art
, bw_vorgang_id
, betrag_verkauf_ist_netto
, CURRENT_TIMESTAMP
, CURRENT_TIMESTAMP

FROM DBP_DATA.lagerbew_det_delta
WHERE mandant_id = 1
;


INSERT INTO DBP_DATA.lagerbew_det_wwc
(
 mandant_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,kj
,dat_buch
,menge_bestand_bme
,wert_bestand
,system_id
,buchungskreis_id
,shkum
,kostenstelle_id
,sachkonto_id
,art_id_empfaenger
,lagerort_id_empfaenger
,art_id_bf
,lagerbew_beleg_pos_mutter_id
,line_id
,endlief_fg
,xruem_fg
,betrag_exbwr
,betrag_bnk
,betrag_umbewertung
,td_insert
,td_update
)
SELECT
mandant_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,kj
,dat_buch
,menge_bestand_bme
,wert_bestand
,system_id
,buchungskreis_id
,shkum
,kostenstelle_id
,sachkonto_id
,art_id_empfaenger
,lagerort_id_empfaenger
,art_id_bf
,lagerbew_beleg_pos_mutter_id
,line_id
,endlief_fg
,xruem_fg
,betrag_exbwr
,betrag_bnk
,betrag_umbewertung
,CURRENT_TIMESTAMP
,CURRENT_TIMESTAMP

FROM DBP_DATA.lagerbew_det_delta
WHERE dat_buch >=1100101
AND mandant_id = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbew_delta
WHERE mandant_id = 1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbew_det_delta
WHERE mandant_id = 1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.de_mseg_work;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.de_mseg_menge;

