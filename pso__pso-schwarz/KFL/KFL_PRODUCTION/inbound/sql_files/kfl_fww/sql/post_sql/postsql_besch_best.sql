UPDATE DBP_DATA.besch_best_det 
SET    
     dat_best_beleg	= _dat_best_beleg_neu

FROM
(SELECT 
	 tmp.mandant_id		AS _mandant_id
	,tmp.best_beleg_id	AS _best_beleg_id
	,tmp.dat_best_beleg     AS _dat_best_beleg_neu
	,bb.dat_best_beleg     	AS _dat_best_beleg_alt
FROM  ${TEMP_TABLE} tmp

INNER JOIN DBP_DATA.besch_best bb
	 ON tmp.mandant_id	= bb.mandant_id
	AND tmp.best_beleg_id   = bb.best_beleg_id
	AND tmp.dat_best_beleg <> bb.dat_best_beleg
) t1 WHERE
     mandant_id		= _mandant_id
 AND best_beleg_id	= _best_beleg_id
 AND dat_best_beleg	= _dat_best_beleg_alt
;

UPDATE DBP_DATA.besch_best 
SET    
     dat_best_beleg            = _dat_best_beleg   
    ,nachbest_fg               = _nachbest_fg    
    ,loesch_fg                 = _loesch_fg
    ,best_beleg_status_id      = _best_beleg_status_id
    ,kunde_id                  = _kunde_id    
    ,bestellart_id             = _bestellart_id
    ,system_id                 = _system_id
    ,dat_aenderung             = _dat_aenderung   
    ,gp_id                     = _gp_id
    ,wup_id                    = _wup_id
    ,einkaufsorganisation_id   = _einkaufsorganisation_id
    ,nb_id                     = _nb_id
FROM
(SELECT
     mandant_id                as _mandant_id
    ,best_beleg_id             as _best_beleg_id
    ,gp_id                     as _gp_id
    ,dat_best_beleg            as _dat_best_beleg
    ,bestellart_id             as _bestellart_id
    ,loesch_fg                 as _loesch_fg
    ,nachbest_fg               as _nachbest_fg
    ,einkaufsorganisation_id   as _einkaufsorganisation_id
    ,kunde_id                  as _kunde_id
    ,dat_aenderung             as _dat_aenderung
    ,wup_id                    as _wup_id
    ,nb_id                     as _nb_id
    ,best_beleg_status_id      as _best_beleg_status_id
    ,system_id                 as _system_id
    ,empfaenger_wup_id         as _empfaenger_wup_id
    ,anz_pos_aktiv             as _anz_pos_aktiv
    ,anz_pos_offen             as _anz_pos_offen
    ,submi_id                  as _submi_id
    ,ref_beleg_id_intern       as _ref_beleg_id_intern
FROM ${TEMP_TABLE}
) t1 WHERE
     mandant_id                = _mandant_id
   AND best_beleg_id           = _best_beleg_id
;
