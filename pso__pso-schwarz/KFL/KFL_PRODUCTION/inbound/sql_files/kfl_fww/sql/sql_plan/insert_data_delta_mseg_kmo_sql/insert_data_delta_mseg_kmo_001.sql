--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_mseg_work;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.kmo_mseg_work  (
      art_id 			INTEGER,
      art_id_bf 		INTEGER NOT NULL,
      art_id_empfaenger 	INTEGER NOT NULL,
      auto_fg 			CHAR(1) COLLATE 'en-ci' NOT NULL,
      beleg_user_name 		CHAR(20) COLLATE 'en-ci' NOT NULL,
      belegart_id 		CHAR(2) COLLATE 'en-ci',
      belegkopftext 		VARCHAR(30) COLLATE 'en-ci',
      best_beleg_id 		DECIMAL(18,0),
      best_beleg_pos_id 	INTEGER NOT NULL,
      betrag_belegfluss_wg_art 	DECIMAL(18,2),
      betrag_bnk 		DECIMAL(18,4) NOT NULL,
      betrag_einstandspreis 	DECIMAL(18,4),
      betrag_exbwr 		DECIMAL(18,4) NOT NULL,
      betrag_lagerbew 		DECIMAL(18,4),
      betrag_umbewertung 	DECIMAL(18,4) NOT NULL,
      betrag_verkauf 		DECIMAL(18,2) NOT NULL,
      betrag_verkauf_ist 	DECIMAL(18,2) NOT NULL,
      betrag_verkauf_ist_netto 	DECIMAL(18,4),
      betrag_vk_netto 		DECIMAL(18,2) NOT NULL,
      betrag_vk_netto_vz 	DECIMAL(18,4) NOT NULL,
      bq_findung_id 		BYTEINT NOT NULL,
      buchungskreis_id 		SMALLINT NOT NULL,
      bw_vorgang_id 		SMALLINT NOT NULL,
      dat_beleg 		DATE NOT NULL,
      dat_buch 			DATE NOT NULL,
      dat_erfasst 		DATE,
      einkaufsorganisation_id 	SMALLINT,
      empfaenger                VARCHAR(10) COLLATE 'en-cs' ,
      empfaenger_id 		INTEGER,
      endlief_fg 		BYTEINT NOT NULL,
      erfsngs_menge_einh_id 	CHAR(3) COLLATE 'en-cs' NOT NULL,
      gp_id 			INTEGER,
      gp_id_zl 			INTEGER,
      grund_id 			CHAR(10) COLLATE 'en-ci' NOT NULL,
      kj 			INTEGER NOT NULL,
      kostenstelle_id 		CHAR(10) COLLATE 'en-ci' NOT NULL,
      kunde_id 			VARCHAR(10) COLLATE 'en-ci', 
      lager_bewart_id 		CHAR(3) COLLATE 'en-ci' NOT NULL,
      lagerbew_beleg_id 	DECIMAL(18,0) NOT NULL,
      lagerbew_beleg_pos_id 	INTEGER NOT NULL,
      lagerbew_beleg_pos_mutter_id INTEGER NOT NULL,
      lagerbew_beleg_pos_storno_id INTEGER,
      lagerbew_beleg_storno_id 	DECIMAL(18,0),
      lagerbew_beleg_storno_kj 	SMALLINT,
      lagerort_id 		CHAR(4) COLLATE 'en-ci' NOT NULL,
      lagerort_id_empfaenger 	CHAR(4) COLLATE 'en-ci' NOT NULL,
      lagerplatz_id 		CHAR(10) COLLATE 'en-ci',
      lief_gp_id 		INTEGER NOT NULL,
      line_id 			INTEGER NOT NULL,
      mandant_id 		BYTEINT NOT NULL,
      mandant_id_empfaenger 	BYTEINT,
      mandant_id_kunde 		BYTEINT,
      menge_bestand_bme 	DECIMAL(18,3) NOT NULL,
      menge_erf 		DECIMAL(18,3) NOT NULL,
      menge_lagerbew_bme 	DECIMAL(18,3) NOT NULL,
      menge_lagerbew_kolli 	DECIMAL(18,3) NOT NULL,
      menge_lagerbew_palette 	DECIMAL(18,3),
      menge_lief 		DECIMAL(18,3) NOT NULL,
      menge_lieferschein 	DECIMAL(18,3) NOT NULL,
      mwst 			DECIMAL(12,2) NOT NULL,
      mwst_id 			BYTEINT NOT NULL,
      nb_id 			SMALLINT NOT NULL,
      ref_lagerbew_beleg_id 	VARCHAR(20) COLLATE 'en-ci',
      ref_lagerbew_beleg_id_num DECIMAL(18,0) NOT NULL,
      sachkonto_id 		CHAR(10) COLLATE 'en-ci' NOT NULL,
      shkum 			CHAR(1) COLLATE 'en-ci' NOT NULL,
      soll_haben_kz 		CHAR(1) COLLATE 'en-ci' NOT NULL,
      spr_id 			SMALLINT NOT NULL,
      system_id 		INTEGER,
      transaktion_code 		CHAR(10) COLLATE 'en-ci',
      vorgangsart_id 		CHAR(2) COLLATE 'en-ci' NOT NULL,
      waren_begl_schein_id 	CHAR(10) COLLATE 'en-ci',
      wert_bestand 		DECIMAL(18,4) NOT NULL,
      wg_art_fg 		BYTEINT NOT NULL,
      wrg_id 			CHAR(3) COLLATE 'en-ci' NOT NULL,
      wup_id 			INTEGER,
      xruem_fg 			BYTEINT NOT NULL,
      zeit_erfasst 		INTEGER NOT NULL
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.kmo_mseg_work
--(  
--art_id,
--art_id_bf,
--art_id_empfaenger,
--auto_fg,
--beleg_user_name,
--belegart_id,
--belegkopftext,
--best_beleg_id,
--best_beleg_pos_id,
--betrag_belegfluss_wg_art,
--betrag_bnk,
----betrag_einstandspreis,
--betrag_exbwr,
--betrag_lagerbew,
--betrag_umbewertung,
--betrag_verkauf,
--betrag_verkauf_ist,
--betrag_verkauf_ist_netto,
--betrag_vk_netto,
--betrag_vk_netto_vz,
--bq_findung_id,
--buchungskreis_id,
--bw_vorgang_id,
--dat_beleg,
--dat_buch,
--dat_erfasst,
--einkaufsorganisation_id,
--empfaenger,
--empfaenger_id,
--endlief_fg,
--erfsngs_menge_einh_id,
--gp_id,
----gp_id_zl,
--grund_id,
--kj, 
--kostenstelle_id,
--kunde_id,
--lager_bewart_id,
--lagerbew_beleg_id,
--lagerbew_beleg_pos_id,
--lagerbew_beleg_pos_mutter_id,
--lagerbew_beleg_pos_storno_id,
--lagerbew_beleg_storno_id, 
--lagerbew_beleg_storno_kj,
--lagerort_id ,  
--lagerort_id_empfaenger ,
--lagerplatz_id ,
--lief_gp_id,   
--line_id,
--mandant_id,
--mandant_id_empfaenger,
----mandant_id_kunde,
--menge_bestand_bme, 
--menge_erf,
--menge_lagerbew_bme,
--menge_lagerbew_kolli,
--menge_lagerbew_palette,
--menge_lief,
--menge_lieferschein,
--mwst,
--mwst_id,
--nb_id,
--ref_lagerbew_beleg_id,
--ref_lagerbew_beleg_id_num,
--sachkonto_id,
--shkum,
--soll_haben_kz,
--spr_id,
--system_id,
--transaktion_code,
--vorgangsart_id,
--waren_begl_schein_id,
--wert_bestand,
--wg_art_fg,
--wrg_id,
--wup_id,
--xruem_fg,
--zeit_erfasst
--)
--SELECT
--	mm.art_id,
--	mm.art_id_bf,
--	mm.art_id_empfaenger,
--	mm.auto_fg,
--	mm.beleg_user_name,
--	mm.belegart_id,
--	mm.belegkopftext,
--	mm.best_beleg_id,
--	mm.best_beleg_pos_id,
--	COALESCE(CAST((bbf.betrag ) AS DECIMAL (18,2)), 0) AS betrag_belegfluss_wg_art,
--	mm.betrag_bnk,
--	--mm.betrag_einstandspreis,
--	mm.betrag_exbwr,
--	mm.betrag_lagerbew,
--	mm.betrag_umbewertung,
--	mm.betrag_verkauf,
--	mm.betrag_verkauf_ist,
--	COALESCE((CAST(mm.betrag_verkauf_ist AS FLOAT) / (mm.mwst+100) * 100),0) AS betrag_verkauf_ist_netto,
--	mm.betrag_vk_netto,
--	mm.betrag_vk_netto_vz,
--	mm.bq_findung_id,
--	mm.buchungskreis_id,
--	mm.bw_vorgang_id,
--	mm.dat_beleg,
--	mm.dat_buch,
--	mm.dat_erfasst,
--	mm.einkaufsorganisation_id,
--	mm.empfaenger,
--	mm.empfaenger_id,
--	mm.endlief_fg,
--	mm.erfsngs_menge_einh_id,
--	mm.gp_id,
--	--mm.gp_id_zl,
--	mm.grund_id,
--	mm.kj, 
--	mm.kostenstelle_id,
--	COALESCE(TRIM(bb.kunde_id) , TRIM(mm.kunnr)) AS kunde_id,
--	mm.lager_bewart_id,
--	mm.lagerbew_beleg_id,
--	mm.lagerbew_beleg_pos_id,
--	mm.lagerbew_beleg_pos_mutter_id,
--	mm.lagerbew_beleg_pos_storno_id,
--	mm.lagerbew_beleg_storno_id, 
--	mm.lagerbew_beleg_storno_kj,
--	mm.lagerort_id ,  
--	mm.lagerort_id_empfaenger ,
--	mm.lagerplatz_id ,
--	mm.lief_gp_id,   
--	mm.line_id,
--	mm.mandant_id,
--	mm.mandant_id_empfaenger,
--	--mm.mandant_id_kunde,
--	mm.menge_bestand_bme, 
--	mm.menge_erf,
--	mm.menge_lagerbew_bme,
--	CAST(  (mm.menge_lagerbew_bme * COALESCE(aukolli_alternativ.umrech_faktor, aukolli_alternativ_q.umrech_faktor, 1))AS DECIMAL (18,3)) AS menge_lagerbew_kolli,
--	CAST(  (mm.menge_lagerbew_bme * COALESCE(aupalette.umrech_faktor, aupalette_q.umrech_faktor,0)) AS DECIMAL(18,3)) AS menge_lagerbew_palette,
--	mm.menge_lief,
--	mm.menge_lieferschein,
--	mm.mwst,
--	mm.mwst_id,
--	mm.nb_id,
--	mm.ref_lagerbew_beleg_id,
--	mm.ref_lagerbew_beleg_id_num,
--	mm.sachkonto_id,
--	mm.shkum,
--	mm.soll_haben_kz,
--	mm.spr_id,
--	mm.system_id,
--	mm.transaktion_code,
--	mm.vorgangsart_id,
--	mm.waren_begl_schein_id,
--	mm.wert_bestand,
--	mm.wg_art_fg,
--	mm.wrg_id,
--	mm.wup_id,
--	mm.xruem_fg,
--	CAST( mm.zeit_erfasst AS  INTEGER FORMAT '99:99:99')
--FROM DBX_LOAD.kmo_mseg_delta mm
--
--LEFT OUTER JOIN 
--        (SELECT *
--         FROM DBX_DATA.besch_best_det
--         -- 20.02.2015, -dba-  Partition Elimination!
--         WHERE (mandant_id,dat_best_beleg)  
--		IN (	SELECT  a.mandant_id, a.dat_best_beleg
--			FROM  	DBX_DATA.besch_best a
--			JOIN    DBX_LOAD.kmo_mseg_delta b
--			ON      a.mandant_id 	= b.mandant_id 
--			AND     a.best_beleg_id = b.best_beleg_id
--			GROUP BY 1,2
--		   )
--        ) bb
--	ON   	bb.mandant_id        	= mm.mandant_id
--	AND 	bb.best_beleg_id 	= mm.best_beleg_id
--	AND 	bb.best_beleg_pos_id 	= mm.best_beleg_pos_id
--	AND 	bb.mandant_id          <> 1
--		  
--LEFT OUTER JOIN DBX_DATA.art_vorschlagswert_per av
--         ON 	av.mandant_id 	= mm.mandant_id 
--	AND	av.art_id  	= mm.art_id
--        AND 	av.dat_von     <= mm.dat_buch
--        AND 	av.dat_bis     >= mm.dat_buch
--
---- Umrechnungsfaktor für Palettenfaktor holen
--LEFT OUTER JOIN DBX_DATA.art_umrechnung_faktor_per aupalette
--         ON  	aupalette.mandant_id       	= mm.mandant_id
--	AND 	aupalette.art_id           	= mm.art_id
--        AND 	aupalette.altnv_menge_einh_id	= av.paletten_faktor_einh_id 
--        AND 	aupalette.dat_von              <= mm.dat_buch
--        AND 	aupalette.dat_bis              >= mm.dat_buch
--
--
---- Umrechnungsfaktor für Default Mengeneinheit holen
--LEFT OUTER JOIN DBX_DATA.art_umrechnung_faktor_per aukolli_alternativ
--         ON aukolli_alternativ.mandant_id = mm.mandant_id
--	AND aukolli_alternativ.art_id     = mm.art_id
--        AND av.ausg_menge_einh_id         = aukolli_alternativ.altnv_menge_einh_id
--        AND aukolli_alternativ.dat_von   <= mm.dat_buch
--        AND aukolli_alternativ.dat_bis   >= mm.dat_buch
--
---- 80991231 Palettenfaktor und Default Mengeneinheit holen
--LEFT OUTER JOIN DBX_DATA.art_vorschlagswert_per av_q
--         ON av_q.mandant_id 	= mm.mandant_id
--	AND av_q.art_id		= mm.art_id    
--        AND av_q.dat_von       <= mm.dat_buch
--        AND av_q.dat_bis       >= mm.dat_buch
--
---- 80991231 Umrechnungsfaktor für Palettenfaktor holen
--LEFT OUTER JOIN DBX_DATA.art_umrechnung_faktor_per aupalette_q
--         ON aupalette_q.mandant_id          	= mm.mandant_id
--	AND aupalette_q.art_id			= mm.art_id                    
--        AND aupalette_q.altnv_menge_einh_id 	= 'PAL'
--        AND aupalette_q.dat_bis             	= 80991231
--
---- 80991231 Umrechnungsfaktor für Default Mengeneinheit holen
--LEFT OUTER JOIN DBX_DATA.art_umrechnung_faktor_per aukolli_alternativ_q
--         ON aukolli_alternativ_q.mandant_id 		= mm.mandant_id
--	AND aukolli_alternativ_q.art_id			= mm.art_id                    
--        AND aukolli_alternativ_q.altnv_menge_einh_id	= av_q.ausg_menge_einh_id         
--        AND aukolli_alternativ_q.dat_bis    		= 80991231
--        
--LEFT OUTER JOIN DBX_DATA.best_belegfluss bbf
--         ON mm.mandant_id            	= bbf.mandant_id
--        AND mm.lagerbew_beleg_id     	= bbf.folge_beleg_id
--        AND mm.lagerbew_beleg_pos_id 	= bbf.folge_beleg_pos_id
--	AND mm.dat_buch              	= bbf.dat_buch
--        AND mm.kj                    	= bbf.kj
--        AND mm.best_beleg_id            = bbf.best_beleg_id
--        AND mm.best_beleg_pos_id        = bbf.best_beleg_pos_id
--	AND mm.wg_art_fg                = 1
--        AND bbf.best_entw_typ_id        = 'E' (NOT CASESPECIFIC)
--        AND bbf.mandant_id              > 1   
--   
--;
--
--Comment from validation checker
--error line 160 at position 35 unexpected 'FORMAT'.
--	CAST( mm.zeit_erfasst AS  INTEGER  ^^^> FORMAT '99:99:99')
--syntax error line 160 at position 42 unexpected ''99:99:99''.
--	CAST( mm.zeit_erfasst AS  INTEGER FORMAT  ^^^> '99:99:99')
--translated statement
INSERT INTO DBP_ETL.kmo_mseg_work
(  
art_id,
art_id_bf,
art_id_empfaenger,
auto_fg,
beleg_user_name,
belegart_id,
belegkopftext,
best_beleg_id,
best_beleg_pos_id,
betrag_belegfluss_wg_art,
betrag_bnk,
--betrag_einstandspreis,
betrag_exbwr,
betrag_lagerbew,
betrag_umbewertung,
betrag_verkauf,
betrag_verkauf_ist,
betrag_verkauf_ist_netto,
betrag_vk_netto,
betrag_vk_netto_vz,
bq_findung_id,
buchungskreis_id,
bw_vorgang_id,
dat_beleg,
dat_buch,
dat_erfasst,
einkaufsorganisation_id,
empfaenger,
empfaenger_id,
endlief_fg,
erfsngs_menge_einh_id,
gp_id,
--gp_id_zl,
grund_id,
kj, 
kostenstelle_id,
kunde_id,
lager_bewart_id,
lagerbew_beleg_id,
lagerbew_beleg_pos_id,
lagerbew_beleg_pos_mutter_id,
lagerbew_beleg_pos_storno_id,
lagerbew_beleg_storno_id, 
lagerbew_beleg_storno_kj,
lagerort_id ,  
lagerort_id_empfaenger ,
lagerplatz_id ,
lief_gp_id,   
line_id,
mandant_id,
mandant_id_empfaenger,
--mandant_id_kunde,
menge_bestand_bme, 
menge_erf,
menge_lagerbew_bme,
menge_lagerbew_kolli,
menge_lagerbew_palette,
menge_lief,
menge_lieferschein,
mwst,
mwst_id,
nb_id,
ref_lagerbew_beleg_id,
ref_lagerbew_beleg_id_num,
sachkonto_id,
shkum,
soll_haben_kz,
spr_id,
system_id,
transaktion_code,
vorgangsart_id,
waren_begl_schein_id,
wert_bestand,
wg_art_fg,
wrg_id,
wup_id,
xruem_fg,
zeit_erfasst
)
SELECT
	mm.art_id,
	mm.art_id_bf,
	mm.art_id_empfaenger,
	mm.auto_fg,
	mm.beleg_user_name,
	mm.belegart_id,
	mm.belegkopftext,
	mm.best_beleg_id,
	mm.best_beleg_pos_id,
	COALESCE(CAST((bbf.betrag_ek_netto ) AS DECIMAL (18,2)), 0) AS betrag_belegfluss_wg_art,
	mm.betrag_bnk,
	--mm.betrag_einstandspreis,
	mm.betrag_exbwr,
	mm.betrag_lagerbew,
	mm.betrag_umbewertung,
	mm.betrag_verkauf,
	mm.betrag_verkauf_ist,
	COALESCE((CAST(mm.betrag_verkauf_ist AS FLOAT) / (mm.mwst+100) * 100),0) AS betrag_verkauf_ist_netto,
	mm.betrag_vk_netto,
	mm.betrag_vk_netto_vz,
	mm.bq_findung_id,
	mm.buchungskreis_id,
	mm.bw_vorgang_id,
	mm.dat_beleg,
	mm.dat_buch,
	mm.dat_erfasst,
	mm.einkaufsorganisation_id,
	mm.empfaenger,
	mm.empfaenger_id,
	mm.endlief_fg,
	mm.erfsngs_menge_einh_id,
	mm.gp_id,
	--mm.gp_id_zl,
	mm.grund_id,
	mm.kj, 
	mm.kostenstelle_id,
	COALESCE(TRIM(bb.kunde_id) , TRIM(mm.kunnr)) AS kunde_id,
	mm.lager_bewart_id,
	mm.lagerbew_beleg_id,
	mm.lagerbew_beleg_pos_id,
	mm.lagerbew_beleg_pos_mutter_id,
	mm.lagerbew_beleg_pos_storno_id,
	mm.lagerbew_beleg_storno_id, 
	mm.lagerbew_beleg_storno_kj,
	mm.lagerort_id ,  
	mm.lagerort_id_empfaenger ,
	mm.lagerplatz_id ,
	mm.lief_gp_id,   
	mm.line_id,
	mm.mandant_id,
	mm.mandant_id_empfaenger,
	--mm.mandant_id_kunde,
	mm.menge_bestand_bme, 
	mm.menge_erf,
	mm.menge_lagerbew_bme,
	CAST(  (mm.menge_lagerbew_bme * COALESCE(aukolli_alternativ.umrech_faktor, aukolli_alternativ_q.umrech_faktor, 1))AS DECIMAL (18,3)) AS menge_lagerbew_kolli,
	CAST(  (mm.menge_lagerbew_bme * COALESCE(aupalette.umrech_faktor, aupalette_q.umrech_faktor,0)) AS DECIMAL(18,3)) AS menge_lagerbew_palette,
	mm.menge_lief,
	mm.menge_lieferschein,
	mm.mwst,
	mm.mwst_id,
	mm.nb_id,
	mm.ref_lagerbew_beleg_id,
	mm.ref_lagerbew_beleg_id_num,
	mm.sachkonto_id,
	mm.shkum,
	mm.soll_haben_kz,
	mm.spr_id,
	mm.system_id,
	mm.transaktion_code,
	mm.vorgangsart_id,
	mm.waren_begl_schein_id,
	mm.wert_bestand,
	mm.wg_art_fg,
	mm.wrg_id,
	mm.wup_id,
	mm.xruem_fg,
	CAST( mm.zeit_erfasst AS  INTEGER FORMAT '99:99:99')
FROM DBP_ETL.kmo_mseg_delta mm

LEFT OUTER JOIN 
        (SELECT *
         FROM DBP_DATA.besch_best_det
         -- 20.02.2015, -dba-  Partition Elimination!
         WHERE (mandant_id,dat_best_beleg)  
		IN (	SELECT  a.mandant_id, a.dat_best_beleg
			FROM  	DBP_DATA.besch_best a
			JOIN    DBP_ETL.kmo_mseg_delta b
			ON      a.mandant_id 	= b.mandant_id 
			AND     a.best_beleg_id = b.best_beleg_id
			GROUP BY 1,2
		   )
        ) bb
	ON   	bb.mandant_id        	= mm.mandant_id
	AND 	bb.best_beleg_id 	= mm.best_beleg_id
	AND 	bb.best_beleg_pos_id 	= mm.best_beleg_pos_id
	AND 	bb.mandant_id          <> 1
		  
LEFT OUTER JOIN DBP_DATA.art_vorschlagswert_per av
         ON 	av.mandant_id 	= mm.mandant_id 
	AND	av.art_id  	= mm.art_id
        AND 	av.dat_von     <= mm.dat_buch
        AND 	av.dat_bis     >= mm.dat_buch

-- Umrechnungsfaktor für Palettenfaktor holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per aupalette
         ON  	aupalette.mandant_id       	= mm.mandant_id
	AND 	aupalette.art_id           	= mm.art_id
        AND 	aupalette.altnv_menge_einh_id	= av.paletten_faktor_einh_id 
        AND 	aupalette.dat_von              <= mm.dat_buch
        AND 	aupalette.dat_bis              >= mm.dat_buch


-- Umrechnungsfaktor für Default Mengeneinheit holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per aukolli_alternativ
         ON aukolli_alternativ.mandant_id = mm.mandant_id
	AND aukolli_alternativ.art_id     = mm.art_id
        AND av.ausg_menge_einh_id         = aukolli_alternativ.altnv_menge_einh_id
        AND aukolli_alternativ.dat_von   <= mm.dat_buch
        AND aukolli_alternativ.dat_bis   >= mm.dat_buch

-- 80991231 Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN DBP_DATA.art_vorschlagswert_per av_q
         ON av_q.mandant_id 	= mm.mandant_id
	AND av_q.art_id		= mm.art_id    
        AND av_q.dat_von       <= mm.dat_buch
        AND av_q.dat_bis       >= mm.dat_buch

-- 80991231 Umrechnungsfaktor für Palettenfaktor holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per aupalette_q
         ON aupalette_q.mandant_id          	= mm.mandant_id
	AND aupalette_q.art_id			= mm.art_id                    
        AND aupalette_q.altnv_menge_einh_id 	= 'PAL'
        AND aupalette_q.dat_bis             	= to_date('9999-12-31','YYYY-MM-DD')

-- 80991231 Umrechnungsfaktor für Default Mengeneinheit holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per aukolli_alternativ_q
         ON aukolli_alternativ_q.mandant_id 		= mm.mandant_id
	AND aukolli_alternativ_q.art_id			= mm.art_id                    
        AND aukolli_alternativ_q.altnv_menge_einh_id	= av_q.ausg_menge_einh_id         
        AND aukolli_alternativ_q.dat_bis    		= to_date('9999-12-31','YYYY-MM-DD')
        
LEFT OUTER JOIN DBP_DATA.best_belegfluss bbf
         ON mm.mandant_id            	= bbf.mandant_id
        AND mm.lagerbew_beleg_id     	= bbf.folge_beleg_id
        AND mm.lagerbew_beleg_pos_id 	= bbf.folge_beleg_pos_id
	AND mm.dat_buch              	= bbf.dat_buch
        AND mm.kj                    	= bbf.kj
        AND mm.best_beleg_id            = bbf.best_beleg_id
        AND mm.best_beleg_pos_id        = bbf.best_beleg_pos_id
	AND mm.wg_art_fg                = 1
        AND bbf.best_entw_typ_id        = 'E' (NOT CASESPECIFIC)
        AND bbf.mandant_id              > 1   
   
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_lagerbew_det_vk_anr;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.kmo_lagerbew_det_vk_anr  (
mandant_id             BYTEINT,
lagerbew_beleg_id      DECIMAL(18,0),
lagerbew_beleg_pos_id  INTEGER,
dat_buch               DATE NOT NULL,
kj                     SMALLINT,
art_id                 INTEGER,
wup_id                 INTEGER,
nb_id                  SMALLINT,
menge_lagerbew_bme     DECIMAL(18,3),
vk_netto               DECIMAL(18,4)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.kmo_lagerbew_det_vk_anr                                
(
	 mandant_id
	,lagerbew_beleg_id
	,lagerbew_beleg_pos_id
	,dat_buch
	,kj
	,art_id
	,wup_id
	,nb_id
	,menge_lagerbew_bme
	,vk_netto
)
SELECT
	 kmw.mandant_id
	,kmw.lagerbew_beleg_id
	,kmw.lagerbew_beleg_pos_id
	,kmw.dat_buch
	,kmw.kj
	,kmw.art_id
	,kmw.wup_id
	,kmw.nb_id
	,kmw.menge_lagerbew_bme
	,CAST(ap.vk_brutto /(CASE       WHEN kmw.mwst_id IS NULL THEN 1
					ELSE 1+(kmw.mwst/100) END ) AS DECIMAL(10,4)
	     ) AS vk_netto
FROM  DBP_ETL.kmo_mseg_work  kmw

LEFT OUTER JOIN DBP_DATA.art_pm_vw_zu_per ap
         ON kmw.mandant_id 	= ap.mandant_id
        AND kmw.art_id  	= ap.art_id
        AND kmw.dat_buch BETWEEN ap.dat_von AND ap.dat_bis
        AND ap.preistyp_id = 0
        AND ap.pm_id = 1
        AND ap.vw_id IN (10,90)
        AND ap.vk_brutto IS NOT NULL 
	AND ap.vk_brutto <> 0

WHERE kmw.nb_id = -111                    
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--UPDATE DBX_LOAD.kmo_mseg_work
-- FROM
-- (
--         SELECT                                
--		 mandant_id             AS mandant_id_
--		,lagerbew_beleg_id      AS lagerbew_beleg_id_
--		,lagerbew_beleg_pos_id  AS lagerbew_beleg_pos_id_
--		,dat_buch               AS dat_buch_
--		,kj                     AS kj_
--		,art_id                 AS art_id_
--		,wup_id                 AS wup_id_
--		,nb_id                  AS nb_id_
--		,COALESCE( CAST(menge_lagerbew_bme  * CAST(vk_netto  AS FLOAT) AS DECIMAL(18,2)),0) AS betrag_vk_vz_netto_
--        FROM DBX_LOAD.kmo_lagerbew_det_vk_anr
--        GROUP BY mandant_id_, lagerbew_beleg_id_, lagerbew_beleg_pos_id_, dat_buch_, art_id_,wup_id_, nb_id_
--        QUALIFY CSUM(1 ,ABS(betrag_vk_vz_netto_ )DESC) = 1
--) dt
--SET betrag_vk_netto_vz = betrag_vk_vz_netto_
--
--WHERE mandant_id = mandant_id_
--AND   lagerbew_beleg_id = lagerbew_beleg_id_
--AND   lagerbew_beleg_pos_id = lagerbew_beleg_pos_id_
--AND   dat_buch = dat_buch_
--AND   kj = kj_
--AND   art_id = art_id_
--AND   wup_id = wup_id_
--AND   nb_id  = nb_id_
--;
--
--Comment from validation checker
--error line 19 at position 49 unexpected 'DESC'.
--        QUALIFY CSUM(1 ,ABS(betrag_vk_vz_netto_ ) ^^^> DESC) = 1
--translated statement
UPDATE DBP_ETL.kmo_mseg_work
 
SET betrag_vk_netto_vz = betrag_vk_vz_netto_

FROM
 (
         SELECT                                
		 mandant_id             AS mandant_id_
		,lagerbew_beleg_id      AS lagerbew_beleg_id_
		,lagerbew_beleg_pos_id  AS lagerbew_beleg_pos_id_
		,dat_buch               AS dat_buch_
		,kj                     AS kj_
		,art_id                 AS art_id_
		,wup_id                 AS wup_id_
		,nb_id                  AS nb_id_
		,COALESCE( CAST(menge_lagerbew_bme  * CAST(vk_netto  AS FLOAT) AS DECIMAL(18,2)),0) AS betrag_vk_vz_netto_
        FROM DBP_ETL.kmo_lagerbew_det_vk_anr
        GROUP BY mandant_id_, lagerbew_beleg_id_, lagerbew_beleg_pos_id_, dat_buch_, art_id_,wup_id_, nb_id_
        QUALIFY CSUM(1 ,ABS(betrag_vk_vz_netto_ )DESC) = 1
) dt WHERE mandant_id = mandant_id_
AND   lagerbew_beleg_id = lagerbew_beleg_id_
AND   lagerbew_beleg_pos_id = lagerbew_beleg_pos_id_
AND   dat_buch = dat_buch_
AND   kj = kj_
AND   art_id = art_id_
AND   wup_id = wup_id_
AND   nb_id  = nb_id_
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE 
FROM 	DBP_DATA.lagerbew_delta
WHERE 	(mandant_id, lagerbew_beleg_id,kj)
IN 	(SELECT mandant_id, lagerbew_beleg_id,kj
	 FROM DBP_ETL.kmo_mseg_work
        )
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO DBX_DATA.lagerbew_delta
--( 
-- mandant_id
--,lagerbew_beleg_id
--,kj
--,vorgangsart_id
--,dat_buch
--,beleg_user_name
--,ref_lagerbew_beleg_id
--,dat_beleg
--,dat_erfasst
--,belegart_id
--,belegkopftext
--,waren_begl_schein_id
--,system_id
--,ref_lagerbew_beleg_id_num
--,lief_gp_id
--,zeit_erfasst
--,transaktion_code
--)
--SELECT
-- mandant_id
--,lagerbew_beleg_id
--,kj
--,vorgangsart_id
--,dat_buch
--,beleg_user_name
--,ref_lagerbew_beleg_id
--,dat_beleg
--,dat_erfasst
--,belegart_id
--,belegkopftext
--,waren_begl_schein_id
--,system_id
--,ref_lagerbew_beleg_id_num
--,lief_gp_id
--,zeit_erfasst
--,transaktion_code
--FROM DBX_LOAD.kmo_mseg_work
--
--GROUP BY
--        mandant_id,
--        lagerbew_beleg_id,
--        kj
--QUALIFY CSUM (1 ,lagerbew_beleg_pos_id DESC) = 1
--;
--
--Comment from validation checker
--error line 45 at position 39 unexpected 'DESC'.
--QUALIFY CSUM (1 ,lagerbew_beleg_pos_id  ^^^> DESC) = 1
--translated statement
INSERT INTO DBP_DATA.lagerbew_delta
( 
 mandant_id
,lagerbew_beleg_id
,kj
,vorgangsart_id
,dat_buch
,beleg_user_name
,ref_lagerbew_beleg_id
,dat_beleg
,dat_erfasst
,belegart_id
,belegkopftext
,waren_begl_schein_id
,system_id
,ref_lagerbew_beleg_id_num
,lief_gp_id
,zeit_erfasst
,transaktion_code
)
SELECT
 mandant_id
,lagerbew_beleg_id
,kj
,vorgangsart_id
,dat_buch
,beleg_user_name
,ref_lagerbew_beleg_id
,dat_beleg
,dat_erfasst
,belegart_id
,belegkopftext
,waren_begl_schein_id
,system_id
,ref_lagerbew_beleg_id_num
,lief_gp_id
,zeit_erfasst
,transaktion_code
FROM DBP_ETL.kmo_mseg_work

GROUP BY
        mandant_id,
        lagerbew_beleg_id,
        kj
QUALIFY CSUM (1 ,lagerbew_beleg_pos_id DESC) = 1
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE 
FROM 	DBP_DATA.lagerbew_det_delta
WHERE 	(mandant_id, lagerbew_beleg_id,lagerbew_beleg_pos_id,kj)
IN
	(SELECT mandant_id, lagerbew_beleg_id,lagerbew_beleg_pos_id,kj
	 FROM 	DBP_ETL.kmo_mseg_work
	)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbew_det_delta
(
         mandant_id
        ,lagerbew_beleg_id
        ,lagerbew_beleg_pos_id
        ,kj
        ,lager_bewart_id
        ,art_id
        ,grund_id
        ,wup_id
        ,nb_id
        ,auto_fg
        ,lagerort_id
        ,gp_id
        ,einkaufsorganisation_id
        ,soll_haben_kz
        ,wrg_id
        ,best_beleg_id
        ,best_beleg_pos_id
        ,betrag_lagerbew
        ,betrag_verkauf
        ,betrag_verkauf_ist
        ,erfsngs_menge_einh_id
        ,lagerplatz_id
        ,kunde_id
        ,mandant_id_kunde
        ,menge_lagerbew_kolli
        ,menge_lagerbew_bme
        ,menge_lagerbew_palette
        ,menge_lieferschein
        ,menge_lief
        ,menge_erf
        ,empfaenger_id
        ,mandant_id_empfaenger
        ,dat_buch
        ,lagerbew_beleg_storno_id
        ,lagerbew_beleg_pos_storno_id
        ,lagerbew_beleg_storno_kj
        ,betrag_vk_netto
        ,betrag_vk_netto_vz
        ,system_id
        ,betrag_belegfluss_wg_art
        ,bw_vorgang_id
        ,betrag_verkauf_ist_netto
        ,menge_bestand_bme
        ,wert_bestand
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
)
SELECT 
	 mandant_id
        ,lagerbew_beleg_id
        ,lagerbew_beleg_pos_id
        ,kj
        ,lager_bewart_id
        ,art_id
        ,grund_id
        ,wup_id
        ,nb_id
        ,auto_fg
        ,lagerort_id
        ,gp_id
        ,einkaufsorganisation_id
        ,soll_haben_kz
        ,wrg_id
        ,best_beleg_id
        ,best_beleg_pos_id
        ,betrag_lagerbew
        ,betrag_verkauf
        ,betrag_verkauf_ist
        ,erfsngs_menge_einh_id
        ,lagerplatz_id
        ,kunde_id
        ,mandant_id_kunde
        ,menge_lagerbew_kolli
        ,menge_lagerbew_bme
        ,menge_lagerbew_palette
        ,menge_lieferschein
        ,menge_lief
        ,menge_erf
        ,empfaenger_id
        ,mandant_id_empfaenger
        ,dat_buch
        ,lagerbew_beleg_storno_id
        ,lagerbew_beleg_pos_storno_id
        ,lagerbew_beleg_storno_kj
        ,betrag_vk_netto
        ,betrag_vk_netto_vz
        ,system_id
        ,betrag_belegfluss_wg_art
        ,bw_vorgang_id
        ,betrag_verkauf_ist_netto
        ,menge_bestand_bme
        ,wert_bestand
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
FROM DBP_ETL.kmo_mseg_work
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.l_vorgangsart
(
	mandant_id,
	vorgangsart_id
)
	SELECT
	 mandant_id
	,vorgangsart_id AS vorgangsart_id
	FROM DBP_ETL.kmo_mseg_work
	WHERE vorgangsart_id IS NOT NULL AND
	(mandant_id, vorgangsart_id) NOT IN
		(SELECT mandant_id, vorgangsart_id
		 FROM DBP_DATA.l_vorgangsart
		)
GROUP BY 1,2
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.vorgangsart_spr_zu
(
	mandant_id,
	vorgangsart_id,
	spr_id,
	vorgangsart_bez
)
SELECT
	  mm.mandant_id
	, mm.vorgangsart_id	AS vorgangsart_id
	, s.spr_id            	AS spr_id
	, 'system generated'  	AS vorgangsart_bez
FROM 	DBP_ETL.kmo_mseg_work mm

INNER JOIN DBP_DATA.mandant_spr_zu man
	ON mm.mandant_id = man.mandant_id

INNER JOIN DBP_DATA.spr s
	ON s.dwh_spr = 1
       AND (s.spr_id = man.spr_id
	OR s.spr_id = 22)

WHERE (mm.mandant_id, mm.vorgangsart_id, s.spr_id) NOT IN
(	SELECT
	mandant_id,
	vorgangsart_id,
	spr_id
FROM DBP_DATA.vorgangsart_spr_zu
)
GROUP BY 1,2,3,4
;

