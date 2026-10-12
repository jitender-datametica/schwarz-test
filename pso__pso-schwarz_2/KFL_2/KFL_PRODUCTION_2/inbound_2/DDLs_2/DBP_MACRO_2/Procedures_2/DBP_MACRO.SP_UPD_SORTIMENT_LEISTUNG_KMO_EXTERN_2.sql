CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_KMO_EXTERN(MANDANT_ID FLOAT, MATCHING_ID FLOAT, ART_ID FLOAT, GTIN VARCHAR, STK_RE_PFLEGE VARCHAR, VORSCHLAG VARCHAR, PRODUKTWISSEN_PFLEGE VARCHAR, LIEFERANTENWISSEN_PFLEGE VARCHAR, LISTUNG_SST_PFLEGE VARCHAR, LISTUNG_K_SST_PFLEGE VARCHAR, KJMO FLOAT, N_K_ARTIKEL FLOAT, NL_ART_BEZ VARCHAR, KJWO_UPDATE FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	var var_matching_id;
	var var_art_id;
	var var_gtin;
	var var_stk_re_pflege;
	var var_vorschlag;
	var var_vorschlag_hr;
	var var_produktwissen_pflege;
	var var_lieferantenwissen_pflege;
	var var_listung_sst_pflege;
	var var_listung_k_sst_pflege;
	var var_kjmo;
	var var_n_k_artikel;
	var var_nl_art_bez;
	var var_kjwo_update;
	var var_sst_tool_fg;
	var var_special_nl;
	var_matching_id = MATCHING_ID;
	var_art_id = ART_ID;
	var_gtin = GTIN;

	if (STK_RE_PFLEGE == ``) {var_stk_re_pflege = null} 
	else {var_stk_re_pflege = STK_RE_PFLEGE};

	var_vorschlag = VORSCHLAG;
	var_vorschlag_hr = VORSCHLAG;
	var_produktwissen_pflege = PRODUKTWISSEN_PFLEGE;
	var_lieferantenwissen_pflege = LIEFERANTENWISSEN_PFLEGE;
	var_listung_sst_pflege = LISTUNG_SST_PFLEGE;
	var_listung_k_sst_pflege = LISTUNG_K_SST_PFLEGE;
	var_kjmo = KJMO;
	var_n_k_artikel = N_K_ARTIKEL;
	var_nl_art_bez = NL_ART_BEZ;
	var_kjwo_update = KJWO_UPDATE;

	if (var_listung_sst_pflege !== null || var_listung_sst_pflege !== ``) {var_special_nl = var_listung_sst_pflege}
	else if ((var_listung_k_sst_pflege !== null || var_listung_k_sst_pflege !== ``) && var_listung_k_sst_pflege.substring(2,1) != null) {var_special_nl = var_listung_k_sst_pflege.substring(2,1)}
	else {var_special_nl = 4};

	if ((var_listung_sst_pflege == null || var_listung_sst_pflege == ``) && (var_listung_k_sst_pflege == null || var_listung_k_sst_pflege == ``) && (var_produktwissen_pflege == null || var_produktwissen_pflege == ``) && (var_lieferantenwissen_pflege == null || var_lieferantenwissen_pflege == ``) && (var_vorschlag == `` || var_vorschlag == null)) {
	   var_nl_art_bez = nl_art_bez;
	} else {
	   if (var_gtin == null || var_gtin != null && (var_gtin == `-9999` || var_gtin == `-9998`)) {
	      if (var_vorschlag == `Zurücksetzen`) {
	         var sql_stmt = `
		UPDATE dbp_data.sortiment_leistung_dba
			SET  stk_re_pflege = NULL
			,produktwissen_pflege = NULL
			,lieferantenwissen_pflege = NULL
			,listung_sst_pflege = NULL
			,listung_k_sst_pflege = NULL
			,umsatz_hr = NULL
			,absatz_hr = NULL
			,rohertrag_hr = NULL
			,listungsaktion = NULL
		WHERE matching_id =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `'' `;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	         var sql_stmt = `
	    DELETE FROM dbp_msi_data.erwartete_entwicklung_2
	    WHERE matching_id =  ''` + MATCHING_ID + `''  AND
	          kjmo =  ''` + KJMO + `''  AND
	          MANDANT_ID =  ''` + MANDANT_ID + `'' `;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      } else if (var_vorschlag == `Keine Veränderung setzen`) {
	         var sql_stmt = `
		UPDATE dbp_data.sortiment_leistung_dba
			SET  listung_sst_pflege = NULL
			,listung_k_sst_pflege = NULL
			,umsatz_hr = NULL
			,absatz_hr = NULL
			,rohertrag_hr = NULL
			,listungsaktion = ''Keine Veränderung''
		WHERE matching_id =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `''  AND (listungsaktion IS NULL OR listungsaktion = '''')`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      } else if (var_vorschlag == `Keine Veränderung`) {
	         var sql_stmt = `
		UPDATE dbp_data.sortiment_leistung_dba
			SET  listung_sst_pflege = NULL
			,listung_k_sst_pflege = NULL
			,umsatz_hr = NULL
			,absatz_hr = NULL
			,rohertrag_hr = NULL
			,listungsaktion = ''Keine Veränderung''
		WHERE matching_id =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `'' `;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      } else if (var_vorschlag == `Keine Veränderung zurücksetzen`) {
	         var sql_stmt = `
		UPDATE dbp_data.sortiment_leistung_dba
			SET  listungsaktion = NULL
		WHERE matching_id =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `''  AND listungsaktion = ''Keine Veränderung''`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      } else if (var_vorschlag == `Produktwissen_2`) {
	         var sql_stmt = `
		UPDATE dbp_data.sortiment_leistung_dba
			SET  produktwissen_pflege = produktwissen_vp
		WHERE matching_id =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `''  AND (produktwissen_pflege IS NULL OR produktwissen_pflege = '''') AND (produktwissen_vp IS NOT NULL AND produktwissen_vp <> '''')`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      } else {
	         if (var_vorschlag_hr == `Wiedereinlistung` || (var_vorschlag_hr == `Neulistung KL-Artikel_2` || var_vorschlag_hr == `Einlistung`)) {
	            var_vorschlag_hr = `Listung erweitern`;
	         }
	         if (var_vorschlag_hr == `Einlistung Potenzial`) {
	            var_vorschlag_hr = `Einlistung Potenzialartikel`;
	         }
	         if ((var_listung_sst_pflege == `` || var_listung_sst_pflege == null) && (var_listung_k_sst_pflege == `` || var_listung_k_sst_pflege == null)) {
	            var_vorschlag_hr = `Auslistung`;
	         }
	         var sql_stmt = `
	
		UPDATE dbp_data.sortiment_leistung_dba
			SET  stk_re_pflege =  ''` + STK_RE_PFLEGE + `'' 
			,produktwissen_pflege =  ''` + PRODUKTWISSEN_PFLEGE + `'' 
			,lieferantenwissen_pflege =  ''` + LIEFERANTENWISSEN_PFLEGE + `'' 
			,listung_sst_pflege = Trim( ''` + LISTUNG_SST_PFLEGE + `'' )
			,listung_k_sst_pflege = Trim( ''` + LISTUNG_K_SST_PFLEGE + `'' )
			,listungsaktion =  ''` + VORSCHLAG + `'' 
		WHERE matching_id =  ''` + MATCHING_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `'' `;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	         if (var_listung_sst_pflege != `` && var_listung_sst_pflege != null || var_listung_k_sst_pflege != `` && var_listung_k_sst_pflege != null || var_vorschlag_hr == `Auslistung`) {
	            if (var_vorschlag_hr == `Auslistung`) {
	               var_listung_sst_pflege = `0`;
	               var_listung_k_sst_pflege = `K0`;
	            }
	            if ((var_listung_sst_pflege == `` || var_listung_sst_pflege == null) && (var_listung_k_sst_pflege == `` || var_listung_k_sst_pflege == null)) {
	               var_vorschlag_hr = `Auslistung`;
	               var_listung_sst_pflege = `0`;
	               var_listung_k_sst_pflege = `K0`;
	            }
	            if (var_listung_sst_pflege == `` || var_listung_sst_pflege == null) {
	               var_listung_sst_pflege = `-1`;
	            }
	            if (var_listung_k_sst_pflege == `` || var_listung_k_sst_pflege == null) {
	               var_listung_k_sst_pflege = `KK`;
	            }
	            var sql_stmt = `
	
		  INSERT INTO dbp_msi_data.sortiment_art_kmo_2 (MANDANT_ID,
	                                              art_id,
	                                              gtin_id,
	                                              status_2,
	                                              kjwo_update)
		  SELECT a.MANDANT_ID,
		  a.art_id,
		  Max(Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
		  Max(a.status_2) AS status_2,
		   ''` + KJWO_UPDATE + `''  AS kjwo_update
	      FROM dbp_etl.art_matching_nielsen_per_kmo_2 a
		  WHERE a.art_matching_id =  ''` + MATCHING_ID + `''  AND
	            a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	            CASE
	              WHEN a.status_2 <> ''N'' AND
	                   a.list_kz = ''A''
	              THEN 1
	              WHEN a.status_2 = ''N''
	              THEN 1
	              ELSE 0
	            END = 1
	      GROUP BY 1,2`;
	            snowflake.createStatement({
	               sqlText : sql_stmt
	            }).execute();
	            //------------------------------------------------------------------------------------------------------
	            //   (I) UPDATE FUER SORTIMENT_LEISTUNG_2 (K-Stufen)
	            //------------------------------------------------------------------------------------------------------
	            var sql_stmt = `
	      UPDATE dbp_data.sortiment_leistung_dba FROM (SELECT CASE
	                                                             WHEN
	                                                           CASE
	                                                             WHEN Max(x.vorschlag_) <> ''dynamic'' THEN Max(x.vorschlag_)
	                                                             WHEN Sum(x.anzahl_reduktion) = 0 AND Sum(x.anzahl_erweiterung) > 0 THEN ''Listung erweitern''
	                                                             WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) = 0 THEN ''Listung reduzieren''
	                                                             WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) > Sum(x.anzahl_erweiterung) THEN ''Listung reduzieren und erweitern''
	                                                             WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) < Sum(x.anzahl_erweiterung) THEN ''Listung erweitern und reduzieren''
	                                                             WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) >= 0 THEN ''Listung erweitern und reduzieren''
	                                                             WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) <= 0 THEN ''Listung reduzieren und erweitern''
															     WHEN Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) THEN ''SOLL-Listung = IST-Listung''
															     ELSE ''SOLL-Listung = IST-Listung''
	                                                           END = ''SOLL-Listung = IST-Listung''
	                                                             THEN 0
	                                                             ELSE Coalesce(TRUNC(Sum(x.umsatz_)/CASE WHEN Max(x.status_2) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END),0)
	                                                           END AS umsatz,
	                                                           CASE
	                                                             WHEN
	                                                           CASE
	                                                             WHEN Max(x.vorschlag_) <> ''dynamic'' THEN Max(x.vorschlag_)
	                                                           WHEN Sum(x.anzahl_reduktion) = 0 AND Sum(x.anzahl_erweiterung) > 0 THEN ''Listung erweitern''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) = 0 THEN ''Listung reduzieren''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) > Sum(x.anzahl_erweiterung) THEN ''Listung reduzieren und erweitern''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) < Sum(x.anzahl_erweiterung) THEN ''Listung erweitern und reduzieren''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) >= 0 THEN ''Listung erweitern und reduzieren''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) <= 0 THEN ''Listung reduzieren und erweitern''
	                                                           WHEN Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) THEN ''SOLL-Listung = IST-Listung''
	                                                           ELSE ''SOLL-Listung = IST-Listung''
	                                                                       END = ''SOLL-Listung = IST-Listung''
	                                                           THEN 0
	                                                           ELSE Coalesce(TRUNC(Sum(x.absatz_)/CASE WHEN Max(x.status_2) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END),0)
	                                                           END AS absatz,
	                                                           CASE
	                                                             WHEN
	                                                           CASE
	                                                             WHEN Max(x.vorschlag_) <> ''dynamic'' THEN Max(x.vorschlag_)
	                                                           WHEN Sum(x.anzahl_reduktion) = 0 AND Sum(x.anzahl_erweiterung) > 0 THEN ''Listung erweitern''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) = 0 THEN ''Listung reduzieren''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) > Sum(x.anzahl_erweiterung) THEN ''Listung reduzieren und erweitern''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) < Sum(x.anzahl_erweiterung) THEN ''Listung erweitern und reduzieren''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) >= 0 THEN ''Listung erweitern und reduzieren''
	                                                           WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) <= 0 THEN ''Listung reduzieren und erweitern''
	                                                           WHEN Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) THEN ''SOLL-Listung = IST-Listung''
	                                                           ELSE ''SOLL-Listung = IST-Listung''
	                                                                       END = ''SOLL-Listung = IST-Listung''
	                                                           THEN 0
	                                                           ELSE Coalesce(TRUNC(Sum(x.rohertrag_)/CASE WHEN Max(x.status_2) = ''G'' THEN 1 ELSE Count(DISTINCT x.art_id) END),0)
	                                                           END AS rohertrag,
	                                                           Sum(x.anzahl_reduktion) AS anzahl_reduktion_,
	                                                           Sum(x.anzahl_erweiterung) AS anzahl_erweiterung_,
	                                                           Max(x.vorschlag_) AS vorschlag__,
	                                                           CASE
	                                                             WHEN vorschlag__ <> ''dynamic'' THEN vorschlag__
	                                                             WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN ''Listung erweitern''
	                                                             WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN ''Listung reduzieren''
	                                                             WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN ''Listung reduzieren und erweitern''
	                                                             WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN ''Listung erweitern und reduzieren''
	                                                             WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ = anzahl_erweiterung_ AND Sum(x.umsatz_) >= 0 THEN ''Listung erweitern und reduzieren''
	                                                             WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ = anzahl_erweiterung_ AND Sum(x.umsatz_) <= 0 THEN ''Listung reduzieren und erweitern''
	                                               WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN ''SOLL-Listung = IST-Listung''
	                                               ELSE ''SOLL-Listung = IST-Listung''
	                                                           END AS vorschlag
	                                                    FROM (-- K-Sicht fuer KL (SST)
	                                                            SELECT a.MANDANT_ID,
	                                                            a.art_id,
	                                                            Max(b.status_2) AS status_2,
	                                                            Min(a.list_kz) AS list_kz_,
	                                                            Sum(a.umsatz_hr) AS umsatz_,
	                                                            Sum(a.absatz_hr) AS absatz_,
	                                                            Sum(a.rohertrag_hr) AS rohertrag_,
	                                                            Cast(0 AS INT) AS anzahl_reduktion,
	                                                            Sum(erweiterung_fg) AS anzahl_erweiterung,
	                                                            CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN Cast(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE Cast(''dynamic'' AS VARCHAR(100)) END AS vorschlag_
	                                                            FROM dbp_msi_data.kl_listung_kmo_2 a
	                                                            JOIN dbp_msi_data.sortiment_art_kmo_2 b
	                                                            ON a.MANDANT_ID = b.MANDANT_ID AND
	                                                            a.art_id = b.art_id AND
	                                                            a.kjwo_update = b.kjwo_update
	                                                            WHERE (a.MANDANT_ID,a.art_id) NOT IN (SELECT MANDANT_ID, art_id FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                            a.listung_art = ''Listung erweitern'' AND
	                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                            a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                            a.sm_id_selected = Cast( ''` + var_listung_sst_pflege + `''  AS INT) AND
	                                                            a.ksm_id IS NULL
	                                                            GROUP BY 1,2
	                                                            UNION ALL
	                                                            SELECT a.MANDANT_ID,
	                                                            a.art_id,
	                                                            Max(b.status_2) AS status_2,
	                                                            Min(a.list_kz) AS list_kz_,
	                                                            Sum(a.umsatz_hr) AS umsatz_,
	                                                            Sum(a.absatz_hr) AS absatz_,
	                                                            Sum(a.rohertrag_hr) AS rohertrag_,
	                                                            Sum(reduktion_fg) AS anzahl_reduktion,
	                                                            Cast(0 AS INT) AS anzahl_erweiterung,
	                                                            CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' ELSE ''dynamic'' END AS vorschlag_
	                                                            FROM dbp_msi_data.kl_listung_kmo_2 a
	                                                            JOIN dbp_msi_data.sortiment_art_kmo_2 b
	                                                            ON a.MANDANT_ID = b.MANDANT_ID AND
	                                                            a.art_id = b.art_id AND
	                                                            a.kjwo_update = b.kjwo_update
	                                                            WHERE (a.MANDANT_ID,a.art_id) NOT IN (SELECT MANDANT_ID, art_id FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                                   a.listung_art = ''Listung reduzieren'' AND
	                                                                   a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                                   a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                                   a.sm_id_selected = Cast( ''` + var_listung_sst_pflege + `''  AS INT) AND
	                                                                   a.sm_id < Cast( ''` + var_listung_sst_pflege + `''  AS INT) AND
	                                                                   a.ksm_id IS NULL
	                                                            GROUP BY 1,2
	                                                            UNION ALL
	                                                            SELECT a.MANDANT_ID,
	                                                            a.art_id,
	                                                            Max(b.status_2) AS status_2,
	                                                            Min(a.list_kz) AS list_kz_,
	                                                            Sum(a.umsatz_hr) AS umsatz_,
	                                                            Sum(a.absatz_hr) AS absatz_,
	                                                            Sum(a.rohertrag_hr) AS rohertrag_,
	                                                            Cast(0 AS INT) AS anzahl_reduktion,
	                                                            Sum(erweiterung_fg) AS anzahl_erweiterung,
	                                                            CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' WHEN list_kz_ IN (''B'',''C1'',''C2'',''D1'',''D2'') THEN Cast(''Einlistung Kauflandartikel'' AS VARCHAR(100)) ELSE Cast(''dynamic'' AS VARCHAR(100)) END AS vorschlag_
	                                                            FROM dbp_msi_data.kl_listung_kmo_2 a
	                                                            JOIN dbp_msi_data.sortiment_art_kmo_2 b
	                                                            ON a.MANDANT_ID = b.MANDANT_ID AND
	                                                            a.art_id = b.art_id AND
	                                                            a.kjwo_update = b.kjwo_update
	                                                            WHERE (a.MANDANT_ID,a.art_id) NOT IN (SELECT MANDANT_ID, art_id FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                                   a.listung_art = ''Listung erweitern'' AND
	                                                                   a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                                   a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                                   Trim(a.ksm_id_selected) = Trim( ''` + var_listung_k_sst_pflege + `'' ) AND
	                                                                   a.sm_id IS NULL
	                                                            GROUP BY 1,2
	                                                            UNION ALL
	                                                            SELECT a.MANDANT_ID,
	                                                            a.art_id,
	                                                            Max(b.status_2) AS status_2,
	                                                            Min(a.list_kz) AS list_kz_,
	                                                            Sum(a.umsatz_hr) AS umsatz_,
	                                                            Sum(a.absatz_hr) AS absatz_,
	                                                            Sum(a.rohertrag_hr) AS rohertrag_,
	                                                            Sum(reduktion_fg) AS anzahl_reduktion,
	                                                            Cast(0 AS INT) AS anzahl_erweiterung,
	                                                            CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' ELSE ''dynamic'' END AS vorschlag_
	                                                            FROM dbp_msi_data.kl_listung_kmo_2 a
	                                                            JOIN dbp_msi_data.sortiment_art_kmo_2 b
	                                                            ON a.MANDANT_ID = b.MANDANT_ID AND
	                                                            a.art_id = b.art_id AND
	                                                            a.kjwo_update = b.kjwo_update
	                                                            WHERE (a.MANDANT_ID,a.art_id) NOT IN (SELECT MANDANT_ID, art_id FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                                   a.listung_art = ''Listung reduzieren'' AND
	                                                                   a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                                   a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                                   Trim(a.ksm_id_selected) = Trim( ''` + var_listung_k_sst_pflege + `'' ) AND
	                                                                   Cast(Substr(Trim(a.ksm_id),2,1) AS INT) < Cast(Substr(Trim( ''` + var_listung_k_sst_pflege + `'' ),2,1) AS INT) AND
	                                                                   a.sm_id IS NULL
	                                                            GROUP BY 1,2
	                                                            UNION ALL
	                                                            SELECT a.MANDANT_ID,
	                                                            a.art_id,
	                                                            Max(b.status_2) AS status_2,
	                                                            Min(a.list_kz) AS list_kz_,
	                                                            Sum(a.umsatz_hr) AS umsatz_,
	                                                            Sum(a.absatz_hr) AS absatz_,
	                                                            Sum(a.rohertrag_hr) AS rohertrag_,
	                                                            Sum(reduktion_fg) AS anzahl_reduktion,
	                                                            Cast(0 AS INT) AS anzahl_erweiterung,
	                                                            CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' ELSE ''dynamic'' END AS vorschlag_
	                                                            FROM dbp_msi_data.kl_listung_kmo_2 a
	                                                            JOIN dbp_msi_data.sortiment_art_kmo_2 b
	                                                            ON a.MANDANT_ID = b.MANDANT_ID AND
	                                                            a.art_id = b.art_id AND
	                                                            a.kjwo_update = b.kjwo_update
	                                                            WHERE (a.MANDANT_ID,a.art_id) NOT IN (SELECT MANDANT_ID, art_id FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                                   a.listung_art = ''Auslistung'' AND
	                                                                   a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                                   a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                                   a.sm_id_selected = Cast( ''` + var_listung_sst_pflege + `''  AS INT) AND
	                                                                   a.ksm_id IS NULL
	                                                            GROUP BY 1,2
	                                                            UNION ALL
	                                                            SELECT a.MANDANT_ID,
	                                                            a.art_id,
	                                                            Max(b.status_2) AS status_2,
	                                                            Min(a.list_kz) AS list_kz_,
	                                                            Sum(a.umsatz_hr) AS umsatz_,
	                                                            Sum(a.absatz_hr) AS absatz_,
	                                                            Sum(a.rohertrag_hr) AS rohertrag_,
	                                                            Sum(reduktion_fg) AS anzahl_reduktion,
	                                                            Cast(0 AS INT) AS anzahl_erweiterung,
	                                                            CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' ELSE ''dynamic'' END AS vorschlag_
	                                                            FROM dbp_msi_data.kl_listung_kmo_2 a
	                                                            JOIN dbp_msi_data.sortiment_art_kmo_2 b
	                                                            ON a.MANDANT_ID = b.MANDANT_ID AND
	                                                            a.art_id = b.art_id AND
	                                                            a.kjwo_update = b.kjwo_update
	                                                            WHERE (a.MANDANT_ID,a.art_id) NOT IN (SELECT MANDANT_ID, art_id FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                                   a.listung_art = ''Auslistung'' AND
	                                                                   a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                                   a.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                                   Trim(a.ksm_id_selected) = Trim( ''` + var_listung_k_sst_pflege + `'' ) AND
	                                                                   a.sm_id IS NULL
	                                                            GROUP BY 1,2
	                                                      UNION ALL
	                                                      SELECT a.MANDANT_ID,
	                                                      1 AS art_id,
	                                                      ''N'' AS status_2,
	                                                      ''A'' AS list_kz,
	                                                      Sum(a.umsatz_hr) AS umsatz_,
	                                                      Sum(a.absatz_hr) AS absatz_,
	                                                      Sum(a.absatz_hr)*Cast(REPLACE( ''` + var_stk_re_pflege + `'' ,'','',''.'') AS FLOAT) AS rohertrag_,
	                                                      Cast(0 AS INT) AS anzahl_reduktion,
	                                                      Count(*) AS anzahl_erweiterung,
	                                                      ''Einlistung Potenzialartikel'' AS vorschlag_
	                                                      FROM dbp_msi_data.nl_listung_kmo_2 a
	                                                      WHERE a.gtin NOT IN (SELECT Cast(Cast(gtin_id AS BIGINT) AS VARCHAR(30)) FROM dbp_etl.not_listed_basis_kmo_2) AND
	                                                            a.gtin =  ''` + GTIN + `''  AND
	                                                            a.listung_art = ''Einlistung Potenzialartikel'' AND
	                                                            a.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                            a.art_nielsen_bez =  ''` + NL_ART_BEZ + `''  AND
	                                                            a.sm_id_selected =  ''` + var_special_nl + `'' 
	                                                      GROUP BY 1,2) x) x2
	
	      SET umsatz_hr = x2.umsatz,
	          absatz_hr = x2.absatz,
	          rohertrag_hr = x2.rohertrag,
	          listungsaktion = CASE WHEN  ''` + var_vorschlag + `'' = ''Auslistung'' THEN ''Auslistung'' ELSE x2.vorschlag END
	
	      WHERE (art_id =  ''` + ART_ID + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `'' ) OR (gtin =  ''` + GTIN + `''  AND kjmo =  ''` + KJMO + `''  AND MANDANT_ID =  ''` + MANDANT_ID + `''  AND nielsen_art_bez =  ''` + NL_ART_BEZ + `''  AND kjwo_update =  ''` + KJWO_UPDATE + `'' )`;
	            snowflake.createStatement({
	               sqlText : sql_stmt
	            }).execute();
	            var sql_stmt = `
	      UPDATE dbp_data.sortiment_leistung_dba FROM (SELECT CASE
	                                                               WHEN listungsaktion = ''Auslistung''
	                                                               THEN listungsaktion
	                                                               WHEN (listung_sst_pflege <> ''N/A'' OR  listung_k_sst_pflege <> ''N/A'') AND
	                                                                     anz_maerkte_k_sst = 0 AND anz_maerkte_sst = 0 AND
	                                                                     anz_maerkte_baustein_sonstige = 0 AND
	                                                                     anz_maerkte_listung_einzel = 0 AND
	                                                                     anz_maerkte_listung_gesamt = 0
	                                                               THEN ''Einlistung Kauflandartikel''
	                                                               ELSE listungsaktion
	                                                             END AS listungsaktion
	                                                      FROM dbp_data.sortiment_leistung_dba
	                                                      WHERE MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	                                                            art_id IS NOT NULL AND
	                                                            kjmo =  ''` + KJMO + `''  AND
	                                                            kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	                                                            matching_id =  ''` + MATCHING_ID + `'' ) z
	
	      SET listungsaktion = z.listungsaktion
	
	      WHERE dbp_data.sortiment_leistung_dba.MANDANT_ID =  ''` + MANDANT_ID + `''  AND
	            dbp_data.sortiment_leistung_dba.kjmo =  ''` + KJMO + `''  AND
	            dbp_data.sortiment_leistung_dba.kjwo_update =  ''` + KJWO_UPDATE + `''  AND
	            dbp_data.sortiment_leistung_dba.matching_id =  ''` + MATCHING_ID + `'' `;
	            snowflake.createStatement({
	               sqlText : sql_stmt
	            }).execute();
	            
	            var sql_stmt = `
	
	   DELETE FROM dbp_msi_data.sortiment_art_kmo_2
	   WHERE (MANDANT_ID,art_id,gtin_id,kjwo_update) IN (SELECT a.MANDANT_ID,
	   a.art_id,
	   Cast(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30)) AS gtin_id,
	    ''` + KJWO_UPDATE + `''  AS kjwo_update
	                                         FROM dbp_etl.art_matching_nielsen_per_kmo_2 a
	                                         WHERE a.art_matching_id =  ''` + MATCHING_ID + `''  AND
	                                               a.MANDANT_ID =  ''` + MANDANT_ID + `'' 
	                                         GROUP BY 1,2,3)`;
	            snowflake.createStatement({
	               sqlText : sql_stmt
	            }).execute();
	         }

	      }

	   }
	}
 
';