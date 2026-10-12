--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.art_1
 
SET  kl_art_id             = _kl_art_id,
     gewart_id             = _gewart_id,
     mwst_id               = _mwst_id,
     loesch_id             = _loesch_id,
     wg_art_fg             = _wg_art_fg,
     lager_prozent         = _lager_prozent,
     temperatur_id         = _temperatur_id,
     saison_id             = _saison_id,
     best_menge_einh_id    = _best_menge_einh_id,
     loeschvorm_fg         = _loeschvorm_fg,
     mhd_zeitraum          = _mhd_zeitraum,
     artikelart_id         = _artikelart_id,
     basismenge_einh_id    = _basismenge_einh_id,
     faktor_nettoinhalt    = _faktor_nettoinhalt,
     artikeltyp_id         = _artikeltyp_id,
     einh_id               = _einh_id,
     kl_art_id_alt         = _kl_art_id_alt,
     positionstyp_grp_id   = _positionstyp_grp_id,
     nettogew              = _nettogew
FROM 
(
SELECT
  art_id                AS _art_id,
  mandant_id            AS _mandant_id,
  kl_art_id             AS _kl_art_id,
  gewart_id             AS _gewart_id,
  mwst_id               AS _mwst_id,
  loesch_id             AS _loesch_id,
  wg_art_fg             AS _wg_art_fg,
  lager_prozent         AS _lager_prozent,
  temperatur_id         AS _temperatur_id,
  saison_id             AS _saison_id,
  best_menge_einh_id    AS _best_menge_einh_id,
  loeschvorm_fg         AS _loeschvorm_fg,
  mhd_zeitraum          AS _mhd_zeitraum,
  artikelart_id         AS _artikelart_id,
  basismenge_einh_id    AS _basismenge_einh_id,
  faktor_nettoinhalt    AS _faktor_nettoinhalt,
  artikeltyp_id         AS _artikeltyp_id,
  einh_id               AS _einh_id,
  kl_art_id_alt         AS _kl_art_id_alt,
  positionstyp_grp_id   AS _positionstyp_grp_id,
  nettogew              AS _nettogew

FROM   ${TEMP_TABLE} /*DBP_ETL.art_temp*/

) dt1
 WHERE art_id       = _art_id
AND   mandant_id   = _mandant_id
;

