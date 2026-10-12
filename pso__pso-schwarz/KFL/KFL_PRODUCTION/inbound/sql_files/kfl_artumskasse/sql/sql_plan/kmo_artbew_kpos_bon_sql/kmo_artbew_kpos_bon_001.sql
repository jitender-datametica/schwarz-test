--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_aktion_relevant;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.kmo_artbew_bon_aktion_relevant  (
  mandant_id  BYTEINT NOT NULL,
  aktion_id   CHAR(10) COLLATE 'en-ci' NOT NULL,
  bewart_id   SMALLINT NOT NULL,
  dat         DATE NOT NULL,
  art_id      INTEGER NOT NULL,
  wup_id      INTEGER NOT NULL,
  nb_id       SMALLINT NOT NULL,
  anz_aktion  SMALLINT NOT NULL
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.artbew_kmo_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.artbew_kmo_tmp  (
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      bewart_id SMALLINT NOT NULL ,
      bewart_det_id INT NOT NULL,
      gp_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      art_id INTEGER NOT NULL,
      dat DATE NOT NULL,
      aktion_id CHAR(10) COLLATE 'en-ci' NOT NULL DEFAULT '          '   ,
      promo_fg BYTEINT NOT NULL DEFAULT 0  ,
      ean_kasse DECIMAL(26,0) NOT NULL DEFAULT 0.  ,
      einkaufsorganisation_id SMALLINT ,
      herst_id INTEGER ,
      mwst_id BYTEINT NOT NULL ,
      menge DECIMAL(18,3) ,
      wrg CHAR(3) COLLATE 'en-ci' ,
      umsatz_netto DECIMAL(18,4),
      diff_umsatz_netto_konz DECIMAL(18,4) ,
      umsatz_mwst_betrag DECIMAL(18,4),
      diff_umsatz_mwst_betrag_konz DECIMAL(18,4) ,
      ek_brutto DECIMAL(18,4),
      diff_ek_brutto_konz DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      diff_ek_netto_konz DECIMAL(18,4),
      ek_nettonetto DECIMAL(18,4),
      diff_ek_nettonetto_konz DECIMAL(18,4),
      ek_kal_basis DECIMAL(18,4),
      diff_ek_kal_basis_konz DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      diff_ek_mep_konz DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      diff_einstandspreis_konz DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      diff_logkostenzuschlag_konz DECIMAL(18,4),
      bezugsweg_id BYTEINT ,
      ek_netto_bnk DECIMAL(18,4),
      diff_ek_netto_bnk_konz DECIMAL(18,4),
      ek_netto_bnk_sachk DECIMAL(18,4),
      diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
      posten_id CHAR(2) COLLATE 'en-ci' ,
      bq_findung_id BYTEINT ,
      ek_gld DECIMAL(18,4) ,
      diff_ek_gld_konz DECIMAL(18,4) ,
      pv_aktion DECIMAL(18,4),
      pv_bby DECIMAL(18,4),
      pv_kdn_bby DECIMAL(18,4),
      pv_kdp_bby DECIMAL(18,4),
      pv_aktion_bby DECIMAL(18,4),
      pv_aktion_kdn_bby DECIMAL(18,4),
      pv_aktion_kdp_bby DECIMAL(18,4))
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.artbew_kmo_tmp_crm;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.artbew_kmo_tmp_crm  (
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      bewart_id SMALLINT NOT NULL ,
      gp_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      art_id INTEGER NOT NULL,
      dat DATE NOT NULL,
      aktion_id CHAR(10) COLLATE 'en-ci' NOT NULL DEFAULT '          '   ,
      promo_fg BYTEINT NOT NULL DEFAULT 0  ,
      ean_kasse DECIMAL(26,0) NOT NULL DEFAULT 0.  ,
      einkaufsorganisation_id SMALLINT ,
      herst_id INTEGER ,
      mwst_id BYTEINT NOT NULL ,
      menge DECIMAL(18,3) ,
      wrg CHAR(3) COLLATE 'en-ci' ,
      umsatz_netto DECIMAL(18,4),
      diff_umsatz_netto_konz DECIMAL(18,4) ,
      umsatz_mwst_betrag DECIMAL(18,4),
      diff_umsatz_mwst_betrag_konz DECIMAL(18,4) ,
      ek_brutto DECIMAL(18,4),
      diff_ek_brutto_konz DECIMAL(18,4),
      ek_netto DECIMAL(18,4),
      diff_ek_netto_konz DECIMAL(18,4),
      ek_nettonetto DECIMAL(18,4),
      diff_ek_nettonetto_konz DECIMAL(18,4),
      ek_kal_basis DECIMAL(18,4),
      diff_ek_kal_basis_konz DECIMAL(18,4),
      ek_mep DECIMAL(18,4),
      diff_ek_mep_konz DECIMAL(18,4),
      einstandspreis DECIMAL(18,4),
      diff_einstandspreis_konz DECIMAL(18,4),
      logkostenzuschlag DECIMAL(18,4),
      diff_logkostenzuschlag_konz DECIMAL(18,4),
      bezugsweg_id BYTEINT ,
      ek_netto_bnk DECIMAL(18,4),
      diff_ek_netto_bnk_konz DECIMAL(18,4),
      ek_netto_bnk_sachk DECIMAL(18,4),
      diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
      posten_id CHAR(2) COLLATE 'en-ci' ,
      bq_findung_id BYTEINT ,
      ek_gld DECIMAL(18,4) ,
      diff_ek_gld_konz DECIMAL(18,4) ,
      kundenkarte_id VARCHAR(255) COLLATE 'en-ci',
      bon_id VARCHAR(25) COLLATE 'en-cs')
;

