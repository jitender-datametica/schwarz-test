--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.besch_best_LBS
WHERE (mandant_id, best_beleg_id, best_beleg_pos_id)
IN
	(SELECT mandant_id, best_beleg_id, best_beleg_pos_id
	 FROM DBP_ETL.besch_best_det_tmp
	)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.besch_best_LBS
(
	 mandant_id
	,best_beleg_id
	,best_beleg_pos_id
	,art_id
	,wup_id
	,nb_id
	,lagerort_id
	,menge_best_bme
	,endlief_fg
	,dat_best_beleg
	,wrg_id
	,ek_netto
	,gp_id
	,bestellart_id
	,komponentenmenge
	,menge_best_kolli
	,loesch_fg
	,selbstabhol_fg
)
SELECT
	  t.mandant_id
	, t.best_beleg_id
	, t.best_beleg_pos_id
	, t.art_id
	, t.wup_id
	, t.nb_id
	, t.lagerort_id
	, CAST(t.menge_best_kolli / (COALESCE(COALESCE(aukolli.umrech_faktor,aukolli_akt.umrech_faktor) , 
                                              COALESCE(aukolli_alternativ.umrech_faktor,aukolli_alternativ_akt.umrech_faktor) , 1))
	  AS DECIMAL(18,3)) AS  menge_best_bme
	, t.endlief_fg
	, t.dat_best_beleg
	, t.wrg_id
	, t.ek_netto  /*in besch_best_det wird fuer LIS der ek_netto_bnk fuer betrag_best gerechnet, in LBS ek_netto */
	,la.gp_id
	,la.bestellart_id
	,t.komponentenmenge
	,t.menge_best_kolli
	,t.loesch_fg
	,t.selbstabhol_fg

FROM DBP_ETL.besch_best_det_tmp t

-- Datum ermitteln
INNER JOIN
( SELECT
      best_beleg_id
    , dat_best_beleg
    , gp_id
    , bestellart_id
  FROM DBP_DATA.besch_best
  WHERE mandant_id = 1     
    AND einkaufsorganisation_id = 1000
) la
  ON t.best_beleg_id = la.best_beleg_id

-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per
  WHERE mandant_id = 1
) aukolli
  ON t.art_id = aukolli.art_id AND t.best_menge_einh_id = aukolli.altnv_menge_einh_id
     AND la.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis

-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen / current state in case there is no as-was record
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per
  WHERE mandant_id = 1
) aukolli_akt
   ON t.art_id = aukolli_akt.art_id AND t.best_menge_einh_id = aukolli_akt.altnv_menge_einh_id
  AND aukolli_akt.dat_bis = '9999-12-31'

-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN
( SELECT
    art_id, paletten_faktor_einh_id, ausg_menge_einh_id, dat_von, dat_bis
  FROM DBP_DATA.art_vorschlagswert_per
  WHERE mandant_id = 1
) av
  ON t.art_id = av.art_id
     AND la.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis


-- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist 
LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per
  WHERE mandant_id = 1
) aukolli_alternativ
  ON t.art_id = aukolli_alternativ.art_id AND av.ausg_menge_einh_id = aukolli_alternativ.altnv_menge_einh_id
     AND la.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND aukolli_alternativ.dat_bis

LEFT OUTER JOIN
( SELECT
    art_id, altnv_menge_einh_id, dat_von, dat_bis, umrech_faktor
  FROM DBP_DATA.art_umrechnung_faktor_per
  WHERE mandant_id = 1
) aukolli_alternativ_akt
  ON t.art_id = aukolli_alternativ_akt.art_id AND av.ausg_menge_einh_id = aukolli_alternativ_akt.altnv_menge_einh_id
   AND aukolli_alternativ_akt.dat_bis = '9999-12-31'

--WHERE la.gp_id NOT BETWEEN 6902 AND 6909 
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.besch_best_LBS 
WHERE nb_id = 99
;

