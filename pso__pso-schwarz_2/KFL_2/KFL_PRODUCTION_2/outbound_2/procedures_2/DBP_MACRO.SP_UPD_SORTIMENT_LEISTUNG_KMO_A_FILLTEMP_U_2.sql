CREATE OR REPLACE PROCEDURE dbp_macro.sp_upd_sortiment_leistung_kmo_a_filltemp_u(IN USER STRING, IN MANDANT_ID STRING, IN MATCHING_ID STRING, IN ART_ID STRING, IN GTIN STRING, IN STK_RE_PFLEGE STRING, IN VORSCHLAG STRING, IN PRODUKTWISSEN_PFLEGE STRING, IN LIEFERANTENWISSEN_PFLEGE STRING, IN LISTUNG_SST_PFLEGE STRING, IN LISTUNG_K_SST_PFLEGE STRING, IN KJMO STRING, IN N_K_ARTIKEL STRING, IN NL_ART_BEZ STRING, IN KJWO_UPDATE STRING)
BEGIN
DECLARE sql STRING;
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql  =  '''INSERT INTO public.input_table_ek_sort_kmo_u_2
(user,mandant_id ,matching_id ,art_id ,gtin,stk_re_pflege,vorschlag,produktwissen_pflege,lieferantenwissen_pflege,listung_sst_pflege ,listung_k_sst_pflege ,kjmo ,n_k_artikel ,nl_art_bez ,kjwo_update)
  VALUES(\' '''||USER||'\', \''||MANDANT_ID||'\', \''||MATCHING_ID||'\',\''||ART_ID||'\', \''||GTIN||'\', \''||STK_RE_PFLEGE||'\', \''||VORSCHLAG||'\', \''||PRODUKTWISSEN_PFLEGE||'\', \''||LIEFERANTENWISSEN_PFLEGE||'\', \''||LISTUNG_SST_PFLEGE||'\', \''||LISTUNG_K_SST_PFLEGE||'\', \''||KJMO||'\', \''||N_K_ARTIKEL||'\', \''||NL_ART_BEZ||'\', \''||KJWO_UPDATE||'\');';
SET sql  =  REGEXP_REPLACE(sql, '\'undefined\'', 'NULL');
SET sql_stmt  =  sql;

EXECUTE IMMEDIATE (sql_stmt);
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;


