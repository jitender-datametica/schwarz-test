CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_KMO (IN_MANDANT_ID FLOAT
, IN_MATCHING_ID FLOAT
, IN_ART_ID FLOAT
, IN_GTIN STRING
, IN_STK_RE_PFLEGE STRING
, IN_VORSCHLAG STRING
, IN_PRODUKTWISSEN_PFLEGE STRING
, IN_LIEFERANTENWISSEN_PFLEGE STRING
, IN_LISTUNG_SST_PFLEGE STRING
, IN_LISTUNG_K_SST_PFLEGE STRING
, IN_KJMO FLOAT
, IN_N_K_ARTIKEL FLOAT
, IN_NL_ART_BEZ STRING
, IN_KJWO_UPDATE FLOAT
)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   var fetch = (count,rows,stmt) => (count && rows.next() && Array.apply(null,Array(stmt.getColumnCount())).map((_,i) => rows.getColumnValue(i + 1))) || [];
   var VAR_MANDANT_ID;
   var VAR_MATCHING_ID;
   var VAR_ART_ID;
   var VAR_GTIN;
   var VAR_STK_RE_PFLEGE;
   var VAR_VORSCHLAG;
   var VAR_VORSCHLAG_HR;
   var VAR_PRODUKTWISSEN_PFLEGE;
   var VAR_LIEFERANTENWISSEN_PFLEGE;
   var VAR_LISTUNG_SST_PFLEGE;
   var VAR_LISTUNG_K_SST_PFLEGE;
   var VAR_KJMO;
   var VAR_N_K_ARTIKEL;
   var VAR_NL_ART_BEZ;
   var VAR_KJWO_UPDATE;
   var VAR_SST_TOOL_FG;
   var VAR_SPECIAL_NL;
   var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT, INTO;
   var fixBind = function (arg) {
      arg = arg == undefined ? null : arg instanceof Date ? arg.toISOString() : arg;
      return arg;
   };
   var EXEC = function (stmt,binds,noCatch,catchFunction) {
      try {
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         ROW_COUNT = _RS.getRowCount();
         ACTIVITY_COUNT = _RS.getNumRowsAffected();
         if (INTO) return {
            INTO : function () {
               return INTO();
            }
         };
      } catch(error) {
         MESSAGE_TEXT = error.message;
         SQLCODE = error.code;
         SQLSTATE = error.state;
         var msg = `ERROR CODE: ${SQLCODE} SQLSTATE: ${SQLSTATE} MESSAGE: ${MESSAGE_TEXT}`;
         if (catchFunction) catchFunction(error);
         if (!noCatch && ERROR_HANDLERS) ERROR_HANDLERS(error); else throw new Error(msg);
      }
   };
   var INTO = function () {
      if (ROW_COUNT) return fetch(ROW_COUNT,_ROWS,_RS); else return [];
   };
   var_mandant_id = IN_MANDANT_ID;
   VAR_MATCHING_ID = IN_MATCHING_ID;
   VAR_ART_ID = IN_ART_ID;
   VAR_GTIN = IN_GTIN;
   VAR_STK_RE_PFLEGE = IN_STK_RE_PFLEGE == `` && null || IN_STK_RE_PFLEGE;
   VAR_VORSCHLAG = IN_VORSCHLAG;
   VAR_VORSCHLAG_HR = IN_VORSCHLAG;
   VAR_PRODUKTWISSEN_PFLEGE = IN_PRODUKTWISSEN_PFLEGE;
   VAR_LIEFERANTENWISSEN_PFLEGE = IN_LIEFERANTENWISSEN_PFLEGE;
   VAR_LISTUNG_SST_PFLEGE = IN_LISTUNG_SST_PFLEGE;
   VAR_LISTUNG_K_SST_PFLEGE = IN_LISTUNG_K_SST_PFLEGE;
   VAR_KJMO = IN_KJMO;
   VAR_N_K_ARTIKEL = IN_N_K_ARTIKEL;
   VAR_NL_ART_BEZ = IN_NL_ART_BEZ;
   VAR_KJWO_UPDATE = IN_KJWO_UPDATE;
   VAR_SPECIAL_NL = (VAR_LISTUNG_SST_PFLEGE != null || VAR_LISTUNG_SST_PFLEGE != ``) && (EXEC(`SELECT
CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/`,[VAR_LISTUNG_SST_PFLEGE]).INTO())[0] || ((VAR_LISTUNG_K_SST_PFLEGE != null || VAR_LISTUNG_K_SST_PFLEGE != ``) && (EXEC(`SELECT
TO_NUMBER(SUBSTR(?,2,1))`,[VAR_LISTUNG_K_SST_PFLEGE]).INTO())[0] != null && (EXEC(`SELECT
TO_NUMBER(SUBSTR(?,2,1))`,[VAR_LISTUNG_K_SST_PFLEGE]).INTO())[0] || 4);
   if ((VAR_LISTUNG_SST_PFLEGE == null || VAR_LISTUNG_SST_PFLEGE == ``) && (VAR_LISTUNG_K_SST_PFLEGE == null || VAR_LISTUNG_K_SST_PFLEGE == ``) && (VAR_PRODUKTWISSEN_PFLEGE == null || VAR_PRODUKTWISSEN_PFLEGE == ``) && (VAR_LIEFERANTENWISSEN_PFLEGE == null || VAR_LIEFERANTENWISSEN_PFLEGE == ``) && (VAR_VORSCHLAG == `` || VAR_VORSCHLAG == null)) {
      VAR_NL_ART_BEZ = NL_ART_BEZ;
   } else {
      if (VAR_GTIN == null || VAR_GTIN != null && ![`-9999`,`-9998`].includes(VAR_GTIN)) {
         if (VAR_VORSCHLAG == `Zurücksetzen`) {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`UPDATE dbp_data.sortiment_leistung SET  stk_re_pflege = NULL
,produktwissen_pflege = NULL
,lieferantenwissen_pflege = NULL
,listung_sst_pflege = NULL
,listung_k_sst_pflege = NULL
,umsatz_hr = NULL
,absatz_hr = NULL
,rohertrag_hr = NULL
,listungsaktion = NULL
WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ?`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`DELETE FROM dbp_msi_data.erwartete_entwicklung
WHERE matching_id = ? AND
      kjmo = ? AND
      mandant_id = ?`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID]);
         } else if (VAR_VORSCHLAG == `Keine Veränderung setzen`) {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`UPDATE dbp_data.sortiment_leistung SET  listung_sst_pflege = NULL
,listung_k_sst_pflege = NULL
,umsatz_hr = NULL
,absatz_hr = NULL
,rohertrag_hr = NULL
,listungsaktion = 'Keine Veränderung'
WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ? AND (listungsaktion IS NULL OR listungsaktion = '')`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]);
         } else if (VAR_VORSCHLAG == `Keine Veränderung`) {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`UPDATE dbp_data.sortiment_leistung SET  listung_sst_pflege = NULL
,listung_k_sst_pflege = NULL
,umsatz_hr = NULL
,absatz_hr = NULL
,rohertrag_hr = NULL
,listungsaktion = 'Keine Veränderung'
WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ?`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]);
         } else if (VAR_VORSCHLAG == `Keine Veränderung zurücksetzen`) {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`UPDATE dbp_data.sortiment_leistung SET  listungsaktion = NULL
WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ? AND listungsaktion = 'Keine Veränderung'`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]);
         } else if (VAR_VORSCHLAG == `Produktwissen`) {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`UPDATE dbp_data.sortiment_leistung SET  produktwissen_pflege = produktwissen_vp
WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ? AND (produktwissen_pflege IS NULL OR produktwissen_pflege = '') AND (produktwissen_vp IS NOT NULL AND produktwissen_vp <> '')`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]);
         } else {
            if ([`Wiedereinlistung`,`Neulistung KL-Artikel`,`Einlistung`].includes(VAR_VORSCHLAG_HR)) {
               VAR_VORSCHLAG_HR = `Listung erweitern`;
            }
            if (`Einlistung Potenzial`.includes(VAR_VORSCHLAG_HR)) {
               VAR_VORSCHLAG_HR = `Einlistung Potenzialartikel`;
            }
            if ((VAR_LISTUNG_SST_PFLEGE == `` || VAR_LISTUNG_SST_PFLEGE == null) && (VAR_LISTUNG_K_SST_PFLEGE == `` || VAR_LISTUNG_K_SST_PFLEGE == null)) {
               VAR_VORSCHLAG_HR = `Auslistung`;
            }
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`UPDATE dbp_data.sortiment_leistung SET  stk_re_pflege = ?
,produktwissen_pflege = ?
,lieferantenwissen_pflege = ?
,listung_sst_pflege = TRIM(?)
,listung_k_sst_pflege = TRIM(?)
,listungsaktion = ?
WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ?`,[IN_STK_RE_PFLEGE,IN_PRODUKTWISSEN_PFLEGE,IN_LIEFERANTENWISSEN_PFLEGE, IN_LISTUNG_SST_PFLEGE, IN_LISTUNG_K_SST_PFLEGE,IN_VORSCHLAG, IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]);
            if (VAR_LISTUNG_SST_PFLEGE != `` && VAR_LISTUNG_SST_PFLEGE != null || VAR_LISTUNG_K_SST_PFLEGE != `` && VAR_LISTUNG_K_SST_PFLEGE != null || VAR_VORSCHLAG_HR == `Auslistung`) {
               if (`Auslistung`.includes(VAR_VORSCHLAG_HR)) {
                  VAR_LISTUNG_SST_PFLEGE = `0`;
                  VAR_LISTUNG_K_SST_PFLEGE = `K0`;
               }
               if ((VAR_LISTUNG_SST_PFLEGE == `` || VAR_LISTUNG_SST_PFLEGE == null) && (VAR_LISTUNG_K_SST_PFLEGE == `` || VAR_LISTUNG_K_SST_PFLEGE == null)) {
                  VAR_VORSCHLAG_HR = `Auslistung`;
                  VAR_LISTUNG_SST_PFLEGE = `0`;
                  VAR_LISTUNG_K_SST_PFLEGE = `K0`;
               }
               if (VAR_LISTUNG_SST_PFLEGE == `` || VAR_LISTUNG_SST_PFLEGE == null) {
                  VAR_LISTUNG_SST_PFLEGE = `-1`;
               }
               if (VAR_LISTUNG_K_SST_PFLEGE == `` || VAR_LISTUNG_K_SST_PFLEGE == null) {
                  VAR_LISTUNG_K_SST_PFLEGE = `KK`;
               }
               // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
               EXEC(`INSERT INTO dbp_msi_data.sortiment_art_kmo (mandant_id,
art_id,
gtin_id,
status,
kjwo_update) SELECT
a.mandant_id,
a.art_id,
MAX(CAST(CAST(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
MAX(a.status) AS status,
? AS kjwo_update
FROM dbp_etl.art_matching_nielsen_per_kmo a
WHERE a.art_matching_id = ? AND
       a.mandant_id = ? AND
       CASE
         WHEN a.status <> 'N' AND
              a.list_kz = 'A'
         THEN 1
         WHEN a.status = 'N'
         THEN 1
         ELSE 0
       END = 1
 GROUP BY 1,2`,[IN_KJWO_UPDATE, IN_MATCHING_ID,IN_MANDANT_ID]);
               // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
               EXEC(`
--------------------------------------------------------------------------------------------------------
--   (I) UPDATE FUER SORTIMENT_LEISTUNG (K-Stufen)
--------------------------------------------------------------------------------------------------------
UPDATE dbp_data.sortiment_leistung SET umsatz_hr = x2.umsatz,
absatz_hr = x2.absatz,
rohertrag_hr = x2.rohertrag,
listungsaktion = CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE x2.vorschlag END FROM (SELECT
CASE
                                                            WHEN
                                                          CASE
                                                            WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
ELSE 'SOLL-Listung = IST-Listung'
            END = 'SOLL-Listung = IST-Listung'
THEN 0
ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0)
END AS umsatz,
CASE
  WHEN
CASE
  WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
ELSE 'SOLL-Listung = IST-Listung'
            END = 'SOLL-Listung = IST-Listung'
THEN 0
ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0)
END AS absatz,
CASE
  WHEN
CASE
  WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
ELSE 'SOLL-Listung = IST-Listung'
            END = 'SOLL-Listung = IST-Listung'
THEN 0
ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0)
END AS rohertrag,
SUM(x.anzahl_reduktion) AS anzahl_reduktion_,
SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_,
MAX(x.vorschlag_) AS vorschlag__,
CASE
  WHEN vorschlag__ <> 'dynamic' THEN vorschlag__
  WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN 'Listung erweitern'
  WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN 'Listung reduzieren'
  WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN 'Listung reduzieren und erweitern'
  WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN 'Listung erweitern und reduzieren'
  WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ = anzahl_erweiterung_ AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
  WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ = anzahl_erweiterung_ AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN 'SOLL-Listung = IST-Listung'
ELSE 'SOLL-Listung = IST-Listung'
END AS vorschlag
FROM (-- K-Sicht fuer KL (SST)
-- Erweiterung!
SELECT
a.mandant_id,
a.art_id,
MAX(b.status) AS status,
MIN(a.list_kz) AS list_kz_,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_,
CAST(TRUNC(0) AS INT) AS anzahl_reduktion,
SUM(erweiterung_fg) AS anzahl_erweiterung,
CASE WHEN ? = 'Auslistung' THEN 'Auslistung' WHEN list_kz_ IN ('B','C1','C2','D1','D2') THEN'Einlistung Kauflandartikel' ELSE'dynamic' END AS vorschlag_
FROM dbp_msi_data.kl_listung_kmo a
JOIN dbp_msi_data.sortiment_art_kmo b
ON a.mandant_id = b.mandant_id AND
   a.art_id = b.art_id AND
   a.kjwo_update = b.kjwo_update
WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                                                                   a.listung_art = 'Listung erweitern' AND
                                                                   a.kjwo_update = ? AND
                                                                   a.mandant_id = ? AND
                                                                   a.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                                                                   a.ksm_id IS NULL
                                                            GROUP BY 1,2
UNION ALL
-- K-Sicht fuer KL (SST)
-- Reduktion!
SELECT
a.mandant_id,
a.art_id,
MAX(b.status) AS status,
MIN(a.list_kz) AS list_kz_,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_,
SUM(reduktion_fg) AS anzahl_reduktion,
CAST(TRUNC(0) AS INT) AS anzahl_erweiterung,
CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
FROM dbp_msi_data.kl_listung_kmo a
JOIN dbp_msi_data.sortiment_art_kmo b
ON a.mandant_id = b.mandant_id AND
   a.art_id = b.art_id AND
   a.kjwo_update = b.kjwo_update
WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                                                                   a.listung_art = 'Listung reduzieren' AND
                                                                   a.kjwo_update = ? AND
                                                                   a.mandant_id = ? AND
                                                                   a.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                                                                   a.sm_id < CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                                                                   a.ksm_id IS NULL
                                                            GROUP BY 1,2
                                                            UNION ALL
-- K-Sicht fuer KL (KSST)
-- Erweiterung!
SELECT
a.mandant_id,
a.art_id,
MAX(b.status) AS status,
MIN(a.list_kz) AS list_kz_,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_,
CAST(TRUNC(0) AS INT) AS anzahl_reduktion,
SUM(erweiterung_fg) AS anzahl_erweiterung,
CASE WHEN ? = 'Auslistung' THEN 'Auslistung' WHEN list_kz_ IN ('B','C1','C2','D1','D2') THEN'Einlistung Kauflandartikel' ELSE'dynamic' END AS vorschlag_
FROM dbp_msi_data.kl_listung_kmo a
JOIN dbp_msi_data.sortiment_art_kmo b
ON a.mandant_id = b.mandant_id AND
   a.art_id = b.art_id AND
   a.kjwo_update = b.kjwo_update
WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                                                                   a.listung_art = 'Listung erweitern' AND
                                                                   a.kjwo_update = ? AND
                                                                   a.mandant_id = ? AND
                                                                   TRIM(a.ksm_id_selected) = TRIM(?) AND
                                                                   a.sm_id IS NULL
                                                            GROUP BY 1,2
                                                            UNION ALL
-- K-Sicht fuer KL (KSST)
-- Reduktion!
SELECT
a.mandant_id,
a.art_id,
MAX(b.status) AS status,
MIN(a.list_kz) AS list_kz_,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_,
SUM(reduktion_fg) AS anzahl_reduktion,
CAST(TRUNC(0) AS INT) AS anzahl_erweiterung,
CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
FROM dbp_msi_data.kl_listung_kmo a
JOIN dbp_msi_data.sortiment_art_kmo b
ON a.mandant_id = b.mandant_id AND
   a.art_id = b.art_id AND
   a.kjwo_update = b.kjwo_update
WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                                                                   a.listung_art = 'Listung reduzieren' AND
                                                                   a.kjwo_update = ? AND
                                                                   a.mandant_id = ? AND
                                                                   TRIM(a.ksm_id_selected) = TRIM(?) AND TO_NUMBER(SUBSTR(TRIM(a.ksm_id),2,1)) < TO_NUMBER(SUBSTR(TRIM(?),2,1)) AND
a.sm_id IS NULL
GROUP BY 1,2
UNION ALL
--K-Sicht fuer KL (SST)
--Auslistung!!!
SELECT
a.mandant_id,
a.art_id,
MAX(b.status) AS status,
MIN(a.list_kz) AS list_kz_,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_,
SUM(reduktion_fg) AS anzahl_reduktion,
CAST(TRUNC(0) AS INT) AS anzahl_erweiterung,
CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
FROM dbp_msi_data.kl_listung_kmo a
JOIN dbp_msi_data.sortiment_art_kmo b
ON a.mandant_id = b.mandant_id AND
   a.art_id = b.art_id AND
   a.kjwo_update = b.kjwo_update
WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                                                                   a.listung_art = 'Auslistung' AND
                                                                   a.kjwo_update = ? AND
                                                                   a.mandant_id = ? AND
                                                                   a.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                                                                   a.ksm_id IS NULL
                                                            GROUP BY 1,2
                                                            UNION ALL
--K-Sicht fuer KL (SST)
--Auslistung!!!
SELECT
a.mandant_id,
a.art_id,
MAX(b.status) AS status,
MIN(a.list_kz) AS list_kz_,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.rohertrag_hr) AS rohertrag_,
SUM(reduktion_fg) AS anzahl_reduktion,
CAST(TRUNC(0) AS INT) AS anzahl_erweiterung,
CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
FROM dbp_msi_data.kl_listung_kmo a
JOIN dbp_msi_data.sortiment_art_kmo b
ON a.mandant_id = b.mandant_id AND
   a.art_id = b.art_id AND
   a.kjwo_update = b.kjwo_update
WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                                                                   a.listung_art = 'Auslistung' AND
                                                                   a.kjwo_update = ? AND
                                                                   a.mandant_id = ? AND
                                                                   TRIM(a.ksm_id_selected) = TRIM(?) AND
                                                                   a.sm_id IS NULL
                                                            GROUP BY 1,2
                                                            -- Regionen on top (Nielsen 1)
                                                      UNION ALL
SELECT
a.mandant_id,
1 AS art_id,
'N' AS status,
'A' AS list_kz,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.absatz_hr)*CAST(REPLACE(?,',','.') AS FLOAT) AS rohertrag_,
CAST(TRUNC(0) AS INT) AS anzahl_reduktion,
COUNT(*) AS anzahl_erweiterung,
'Einlistung Potenzialartikel' AS vorschlag_
FROM dbp_msi_data.nl_listung_kmo a
WHERE a.gtin NOT IN (SELECT
CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30))
FROM dbp_etl.not_listed_basis_kmo) AND
a.gtin = ? AND
a.listung_art = 'Einlistung Potenzialartikel' AND
a.kjwo_update = ? AND
a.art_nielsen_bez = ? AND
a.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
a.ksm_id IS NULL
GROUP BY 1,2
UNION ALL
SELECT
a.mandant_id,
1 AS art_id,
'N' AS status,
'A' AS list_kz,
SUM(a.umsatz_hr) AS umsatz_,
SUM(a.absatz_hr) AS absatz_,
SUM(a.absatz_hr)*CAST(REPLACE(?,',','.') AS FLOAT) AS rohertrag_,
CAST(TRUNC(0) AS INT) AS anzahl_reduktion,
COUNT(*) AS anzahl_erweiterung,
'Einlistung Potenzialartikel' AS vorschlag_
FROM dbp_msi_data.nl_listung_kmo a
WHERE a.gtin NOT IN (SELECT
CAST(CAST(gtin_id AS BIGINT) AS VARCHAR(30))
FROM dbp_etl.not_listed_basis_kmo) AND
a.gtin = ? AND
a.listung_art = 'Einlistung Potenzialartikel' AND
a.kjwo_update = ? AND
a.art_nielsen_bez = ? AND
TRIM(a.ksm_id_selected) = TRIM(?) AND
a.sm_id IS NULL
GROUP BY 1,2) x) x2

WHERE (art_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = ?) OR (gtin = ? AND kjmo = ? AND mandant_id = ? AND nielsen_art_bez = ? AND kjwo_update = ?)`
,[IN_KJWO_UPDATE
,VAR_VORSCHLAG_HR
,IN_MANDANT_ID
,VAR_LISTUNG_SST_PFLEGE
,VAR_VORSCHLAG_HR
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_SST_PFLEGE
,VAR_LISTUNG_SST_PFLEGE,
,VAR_VORSCHLAG_HR
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_K_SST_PFLEGE
,VAR_VORSCHLAG_HR
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_K_SST_PFLEGE
,VAR_LISTUNG_K_SST_PFLEGE
,IN_KJWO_UPDATE,IN_MANDANT_ID
,VAR_LISTUNG_SST_PFLEGE
,VAR_VORSCHLAG_HR
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_K_SST_PFLEGE
,IN_GTIN
,VAR_VORSCHLAG_HR
,IN_KJWO_UPDATE
,VAR_STK_RE_PFLEGE
,VAR_LISTUNG_SST_PFLEGE
,IN_GTIN
,VAR_NL_ART_BEZ
,IN_KJWO_UPDATE
,VAR_STK_RE_PFLEGE
,VAR_LISTUNG_K_SST_PFLEGE
,VAR_VORSCHLAG_HR
,VAR_NL_ART_BEZ
,IN_ART_ID
,IN_KJMO
,IN_MANDANT_ID
,IN_KJWO_UPDATE
,IN_GTIN
,IN_KJMO
,IN_MANDANT_ID
,VAR_NL_ART_BEZ
,IN_KJWO_UPDATE]);
               // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
               EXEC(`UPDATE dbp_data.sortiment_leistung SET listungsaktion = z.listungsaktion FROM (SELECT
CASE
                                                              WHEN listungsaktion = 'Auslistung'
                                                              THEN listungsaktion
                                                              WHEN (listung_sst_pflege <> 'N/A' OR  listung_k_sst_pflege <> 'N/A') AND
                                                                    anz_maerkte_k_sst = 0 AND anz_maerkte_sst = 0 AND
                                                                    anz_maerkte_baustein_sonstige = 0 AND
                                                                    anz_maerkte_listung_einzel = 0 AND
                                                                    anz_maerkte_listung_gesamt = 0
                                                              THEN 'Einlistung Kauflandartikel'
                                                              ELSE listungsaktion
                                                            END AS listungsaktion
FROM dbp_data.sortiment_leistung
                                                     WHERE mandant_id = ? AND
                                                           art_id IS NOT NULL AND
                                                           kjmo = ? AND
                                                           kjwo_update = ? AND
                                                           matching_id = ?) z

WHERE dbp_data.sortiment_leistung.mandant_id = ? AND
      dbp_data.sortiment_leistung.kjmo = ? AND
      dbp_data.sortiment_leistung.kjwo_update = ? AND
      dbp_data.sortiment_leistung.matching_id = ?`,[IN_MANDANT_ID,IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID,IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID]);
               //------------------------------------------------------------------------------------------------------
               //   (II) INSERT FUER ERWARTETE ENTWICKLUNG (K-Stufen)
               //------------------------------------------------------------------------------------------------------
               if (!([`Keine Veränderung`,`Keine Veränderung setzen`,`Keine Veränderung zurücksetzen`,`Produktwissen`,`Zurücksetzen`] || VAR_VORSCHLAG_HR == null).includes(VAR_VORSCHLAG_HR)) {
                  // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
                  EXEC(`DELETE FROM dbp_msi_data.erwartete_entwicklung
WHERE matching_id = ? AND
      kjmo = ? AND
      mandant_id = ?`,[IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID]);
                  // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
                  EXEC(`INSERT INTO dbp_msi_data.erwartete_entwicklung (mandant_id
,kjmo
,matching_id
,kjwo_update
,wrg_id
,kl_wg_id
,kl_owg_id
,kl_uwg_id
,owg_id
,wg_id
,wug_id
,sm_id
,ksm_id
,umsatz_hr
,absatz_hr
,rohertrag_hr) SELECT
?,
? AS kjmo,
?,
? AS kjwo_update,
z3.default_wrg AS wrg_id,
y3.kl_wg_id,
y3.kl_owg_id,
y3.kl_uwg_id,
y3.kl_wg_id AS owg_id,
y3.kl_owg_id AS wg_id,
y3.kl_uwg_id AS wug_id,
x3.sm_id,
x3.ksm_id,
COALESCE(SUM(x3.umsatz_)/CASE WHEN MAX(x3.status) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END,0) AS umsatz,
COALESCE(SUM(x3.absatz_)/CASE WHEN MAX(x3.status) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END,0) AS absatz,
COALESCE(SUM(x3.rohertrag_)/CASE WHEN MAX(x3.status) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END,0) AS rohertrag
FROM (-- K-Sicht fuer KL (SST)
-- Erweiterung!
SELECT
? AS mandant_id,
? AS matching_id,
a4.sm_id,
'  ' AS ksm_id,
a4.art_id,
MAX(b4.status) AS status,
SUM(a4.umsatz_hr) AS umsatz_,
SUM(a4.absatz_hr) AS absatz_,
SUM(a4.rohertrag_hr) AS rohertrag_
FROM dbp_msi_data.kl_listung_kmo a4
JOIN dbp_msi_data.sortiment_art_kmo b4
ON a4.mandant_id = b4.mandant_id AND
   a4.art_id = b4.art_id
WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                     a4.listung_art = 'Listung erweitern' AND
                     a4.kjwo_update = ? AND
                     a4.mandant_id = ? AND
                     a4.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                     a4.ksm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
UNION ALL
-- K-Sicht fuer KL (SST)
-- Reduktion!
SELECT
? AS mandant_id,
? AS matching_id,
a4.sm_id,
'  ' AS ksm_id,
a4.art_id,
MAX(b4.status) AS status,
SUM(a4.umsatz_hr) AS umsatz_,
SUM(a4.absatz_hr) AS absatz_,
SUM(a4.rohertrag_hr) AS rohertrag_
FROM dbp_msi_data.kl_listung_kmo a4
JOIN dbp_msi_data.sortiment_art_kmo b4
ON a4.mandant_id = b4.mandant_id AND
   a4.art_id = b4.art_id
WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                     a4.listung_art = 'Listung reduzieren' AND
                     a4.kjwo_update = ? AND
                     a4.mandant_id = ? AND
                     a4.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                     a4.sm_id < CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                     a4.ksm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
--K-Sicht fuer KL (K-SST)
--Erweiterung!
SELECT
? AS mandant_id,
? AS matching_id,
-1 AS sm_id,
TRIM(a4.ksm_id) AS ksm_id,
a4.art_id,
MAX(b4.status) AS status,
SUM(a4.umsatz_hr) AS umsatz_,
SUM(a4.absatz_hr) AS absatz_,
SUM(a4.rohertrag_hr) AS rohertrag_
FROM dbp_msi_data.kl_listung_kmo a4
JOIN dbp_msi_data.sortiment_art_kmo b4
ON a4.mandant_id = b4.mandant_id AND
   a4.art_id = b4.art_id
WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                     a4.listung_art = 'Listung erweitern' AND
                     a4.kjwo_update = ? AND
                     a4.mandant_id = ? AND
                     TRIM(a4.ksm_id_selected) = TRIM(?) AND
                     a4.sm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
--K-Sicht fuer KL (K-SST)
--Reduktion
SELECT
? AS mandant_id,
? AS matching_id,
-1 AS sm_id,
TRIM(a4.ksm_id) AS ksm_id,
a4.art_id,
MAX(b4.status) AS status,
SUM(a4.umsatz_hr) AS umsatz_,
SUM(a4.absatz_hr) AS absatz_,
SUM(a4.rohertrag_hr) AS rohertrag_
FROM dbp_msi_data.kl_listung_kmo a4
JOIN dbp_msi_data.sortiment_art_kmo b4
ON a4.mandant_id = b4.mandant_id AND
   a4.art_id = b4.art_id
WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                     a4.listung_art = 'Listung reduzieren' AND
                     a4.kjwo_update = ? AND
                     a4.mandant_id = ? AND
                     TRIM(a4.ksm_id_selected) = TRIM(?) AND TO_NUMBER(SUBSTR(TRIM(a4.ksm_id),2,1)) < TO_NUMBER(SUBSTR(TRIM(?),2,1)) AND
a4.sm_id IS NULL
GROUP BY 1,2,3,4,5
HAVING umsatz_ <> 0
UNION ALL
--K-Sicht fuer KL (K-SST)
--Auslistung!
SELECT
? AS mandant_id,
? AS matching_id,
-1 AS sm_id,
TRIM(a4.ksm_id) AS ksm_id,
a4.art_id,
MAX(b4.status) AS status,
SUM(a4.umsatz_hr) AS umsatz_,
SUM(a4.absatz_hr) AS absatz_,
SUM(a4.rohertrag_hr) AS rohertrag_
FROM dbp_msi_data.kl_listung_kmo a4
JOIN dbp_msi_data.sortiment_art_kmo b4
ON a4.mandant_id = b4.mandant_id AND
   a4.art_id = b4.art_id
WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                     a4.listung_art = 'Auslistung' AND
                     a4.kjwo_update = ? AND
                     a4.mandant_id = ? AND
                     TRIM(a4.ksm_id_selected) = TRIM(?) AND
                     a4.sm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
--K-Sicht fuer KL (SST)
--Auslistung!
SELECT
?AS mandant_id,
? AS matching_id,
a4.sm_id,
'  ' AS ksm_id,
a4.art_id,
MAX(b4.status) AS status,
SUM(a4.umsatz_hr) AS umsatz_,
SUM(a4.absatz_hr) AS absatz_,
SUM(a4.rohertrag_hr) AS rohertrag_
FROM dbp_msi_data.kl_listung_kmo a4
JOIN dbp_msi_data.sortiment_art_kmo b4
ON a4.mandant_id = b4.mandant_id AND
   a4.art_id = b4.art_id
WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT
mandant_id,
art_id
FROM dbp_etl.not_listed_basis_kmo) AND
                     a4.listung_art = 'Auslistung' AND
                     a4.kjwo_update = ? AND
                     a4.mandant_id = ? AND
                     a4.sm_id_selected = CAST(TRUNC(?) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AND
                     a4.ksm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0) x3
        JOIN (SELECT
mandant_id,
art_matching_id,
MAX(kl_wg_id) AS kl_wg_id,
MAX(kl_owg_id) AS kl_owg_id,
MAX(kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo
GROUP BY 1,2) y3
ON x3.matching_id = y3.art_matching_id AND
x3.mandant_id = y3.mandant_id
JOIN dbp_data.mandant z3
ON ? = z3.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13`
,[IN_MANDANT_ID
, IN_KJMO
,IN_MATCHING_ID
, IN_KJWO_UPDATE
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,IN_MATCHING_ID
,IN_MANDANT_ID
,IN_MANDANT_ID
,IN_MATCHING_ID
,VAR_LISTUNG_SST_PFLEGE
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_SST_PFLEGE
,VAR_LISTUNG_SST_PFLEGE
,IN_MANDANT_ID
,IN_MATCHING_ID
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_K_SST_PFLEGE
,IN_MANDANT_ID
,IN_MATCHING_ID
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_K_SST_PFLEGE
,VAR_LISTUNG_K_SST_PFLEGE
,IN_MANDANT_ID
,IN_MATCHING_ID
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_K_SST_PFLEGE
,IN_MANDANT_ID
,IN_MATCHING_ID
,IN_KJWO_UPDATE
,IN_MANDANT_ID
,VAR_LISTUNG_SST_PFLEGE
,IN_MANDANT_ID]
);
               }
               // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
               EXEC(`DELETE FROM dbp_msi_data.sortiment_art_kmo
WHERE (mandant_id,art_id,gtin_id,kjwo_update) IN (SELECT
a.mandant_id,
a.art_id,
CAST(CAST(a.gtin_id AS BIGINT) AS VARCHAR(30)) AS gtin_id,
? AS kjwo_update
FROM dbp_etl.art_matching_nielsen_per_kmo a
WHERE a.art_matching_id = ? AND
      a.mandant_id = ?
GROUP BY 1,2,3)`,[IN_KJWO_UPDATE, IN_MATCHING_ID,IN_MANDANT_ID]);
            }
         }
         if (VAR_VORSCHLAG == `Zurücksetzen`) {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE kjmo = ? AND
      kjwo_update = ? AND
      art_matching_id = ? AND
      mandant_id = ?`,[IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`INSERT INTO dbp_data.art_kl_preislage_zu_per_neu SELECT
*
FROM dbp_data.art_kl_preislage_zu_per
  WHERE kjmo = ? AND
        kjwo_update = ? AND
        art_matching_id = ? AND
        mandant_id = ?`,[IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID]);
         } else {
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
,art_matching_id
,kjmo
,kjwo_update
,wrg_id
,sm_id
,ksm_id
,owg_id
,wg_id
,wug_id
,vk_brutto_pk_1
,durchschnitt_preis_kasse
,umsatz_brutto
,umsatz_brutto_af
,umsatz_brutto_sa
,menge
,menge_af
,menge_sa) SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.kjmo,
a.kjwo_update,
x.default_wrg AS wrg_id,
TRIM(CAST(b.k AS VARCHAR(10))) AS sm_id,
'' AS ksm_id,
a.kl_wg_id AS owg_id,
a.kl_owg_id AS wg_id,
a.kl_uwg_id AS wug_id,
a.vk_preis,
a.durchschnittspreis,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_data.sortiment_leistung a
JOIN dbp_data.art_kl_preislage_zu_per_neu c
ON a.mandant_id = c.mandant_id AND
   a.kjmo = c.kjmo AND
   a.matching_id = c.art_matching_id AND
   a.listung_sst_mvke = c.sm_id
JOIN (SELECT
wtag_id AS k
FROM dbp_data.tag
     WHERE wtag_id BETWEEN 1 AND 5
     GROUP BY 1) b
 ON TO_NUMBER(TRIM(a.listung_sst_pflege)) <= b.k AND
b.k < CASE
        WHEN a.listung_sst_mvke = 'N/A'
        THEN 6
        ELSE CAST(TRUNC(a.listung_sst_mvke) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
END
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.umsatz_hr IS NOT NULL AND
    a.mandant_id = ? AND
    a.kjmo IN (SELECT
kjmo
FROM dbp_data.monat
                WHERE kjmo = ?) AND
     a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND
    (a.mandant_id,a.matching_id,a.kjmo,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjmo,
CAST(TRUNC(sm_id) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE sm_id NOT IN ('N/A','-1') AND
      mandant_id = ?)`,[IN_MANDANT_ID,IN_KJMO,IN_MANDANT_ID]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
,art_matching_id
,kjmo
,kjwo_update
,wrg_id
,sm_id
,ksm_id
,owg_id
,wg_id
,wug_id
,vk_brutto_pk_1
,durchschnitt_preis_kasse
,umsatz_brutto
,umsatz_brutto_af
,umsatz_brutto_sa
,menge
,menge_af
,menge_sa) SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.kjmo,
a.kjwo_update,
x.default_wrg AS wrg_id,
TRIM(CAST(b.k AS VARCHAR(10))) AS sm_id,
'' AS ksm_id,
a.kl_wg_id AS owg_id,
a.kl_owg_id AS wg_id,
a.kl_uwg_id AS wug_id,
a.vk_preis,
a.durchschnittspreis,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_data.sortiment_leistung a
JOIN dbp_data.art_kl_preislage_zu_per_neu c
ON a.mandant_id = c.mandant_id AND
   a.kjmo = c.kjmo AND
   a.matching_id = c.art_matching_id AND
   a.listung_k_sst_mvke = c.ksm_id
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
     WHERE akt_tag BETWEEN 1 AND 9
     GROUP BY 1) b
 ON TO_NUMBER(TRIM(SUBSTR(a.listung_k_sst_pflege,2,1))) <= b.k AND
b.k < CASE
        WHEN a.listung_k_sst_mvke = 'N/A'
        THEN 10
        ELSE TO_NUMBER(SUBSTR(a.listung_k_sst_mvke,2,1))
END
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.umsatz_hr IS NOT NULL AND
    a.mandant_id = ? AND
    a.kjmo IN (SELECT
kjmo
FROM dbp_data.monat
                WHERE kjmo = ?) AND
     a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND
    (a.mandant_id,a.matching_id,a.kjmo,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjmo,
TO_NUMBER(SUBSTR(ksm_id,2,1))
FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE ksm_id NOT IN ('') AND
      mandant_id = ?)`,[IN_MANDANT_ID,IN_KJMO,IN_MANDANT_ID]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
,art_matching_id
,kjmo
,kjwo_update
,wrg_id
,sm_id
,ksm_id
,owg_id
,wg_id
,wug_id
,vk_brutto_pk_1
,durchschnitt_preis_kasse
,umsatz_brutto
,umsatz_brutto_af
,umsatz_brutto_sa
,menge
,menge_af
,menge_sa) SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.kjmo,
a.kjwo_update,
x.default_wrg AS wrg_id,
-1 AS sm_id,
'K'||TRIM(CAST(b.k AS VARCHAR(10))) AS ksm_id,
a.kl_wg_id AS owg_id,
a.kl_owg_id AS wg_id,
a.kl_uwg_id AS wug_id,
a.vk_preis,
a.durchschnittspreis,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_data.sortiment_leistung a
JOIN dbp_data.art_kl_preislage_zu_per_neu c
ON a.mandant_id = c.mandant_id AND
   a.kjwo_update = c.kjwo_update AND
   a.matching_id = c.art_matching_id AND
   a.listung_k_sst_mvke = c.ksm_id
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
     WHERE akt_tag BETWEEN 1 AND 9
     GROUP BY 1) b
 ON TO_NUMBER(TRIM(SUBSTR(COALESCE(a.listung_k_sst_pflege,'K9'),2,1))) <= b.k AND
b.k < TO_NUMBER(SUBSTR(COALESCE(a.listung_k_sst_mvke,'K9'),2,1))
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.umsatz_hr IS NOT NULL AND
    a.mandant_id = ? AND
    a.kjwo_update = ? AND
    a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND
   (a.mandant_id,a.matching_id,a.kjwo_update,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjwo_update,
TO_NUMBER(SUBSTR(ksm_id,2,1))
FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE ksm_id IS NOT NULL AND
      ksm_id <> '' AND
      kjwo_update = ? AND
      mandant_id = ?)`,[IN_MANDANT_ID,IN_KJWO_UPDATE,IN_KJWO_UPDATE,IN_MANDANT_ID]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE (mandant_id,art_matching_id,kjmo,ksm_id,kjwo_update) IN (SELECT
a.mandant_id,
a.matching_id,
a.kjmo,
'K'||CAST(b.k AS VARCHAR(10)),
a.kjwo_update
FROM dbp_data.sortiment_leistung a
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
                                                                   WHERE akt_tag BETWEEN 1 AND 9
                                                                   GROUP BY 1) b
                                                               ON TO_NUMBER(SUBSTR(COALESCE(a.listung_k_sst_pflege,'K9'),2,1)) > b.k AND
b.k <= TO_NUMBER(SUBSTR(COALESCE(a.listung_k_sst_mvke,'K9'),2,1))
WHERE a.kjwo_update = ? AND
      a.umsatz_hr IS NOT NULL AND
      a.mandant_id = ? AND
      a.listungsaktion IN ('Listung reduzieren','Listung reduzieren und erweitern','Listung erweitern und reduzieren'))`,[IN_KJWO_UPDATE,IN_MANDANT_ID]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
,art_matching_id
,kjmo
,kjwo_update
,wrg_id
,sm_id
,ksm_id
,owg_id
,wg_id
,wug_id
,vk_brutto_pk_1
,durchschnitt_preis_kasse
,umsatz_brutto
,umsatz_brutto_af
,umsatz_brutto_sa
,menge
,menge_af
,menge_sa) SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.kjmo,
a.kjwo_update,
x.default_wrg AS wrg_id,
-1 AS sm_id,
'K'||TRIM(CAST(b.k AS VARCHAR(10))) AS ksm_id,
a.kl_wg_id AS owg_id,
a.kl_owg_id AS wg_id,
a.kl_uwg_id AS wug_id,
a.vk_preis,
a.durchschnittspreis,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_data.sortiment_leistung a
JOIN dbp_data.art_nielsen_preislage_zu_per c
ON a.mandant_id = c.mandant_id AND
   a.kjmo = c.kjmo AND
 a.matching_id = c.art_matching_id AND
 a.kjwo_update = ?
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
     WHERE akt_tag BETWEEN 1 AND 9
     GROUP BY 1) b
 ON TO_NUMBER(TRIM(SUBSTR(COALESCE(a.listung_k_sst_pflege,'K9'),2,1))) <= b.k
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.umsatz_hr IS NOT NULL AND
    a.mandant_id = ? AND
    a.kjwo_update = ? AND
    a.listungsaktion = 'Einlistung Potenzialartikel' AND
   (a.mandant_id,a.matching_id,a.kjwo_update,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjwo_update,
TO_NUMBER(SUBSTR(ksm_id,2,1))
FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE ksm_id IS NOT NULL AND
      ksm_id <> '' AND
      kjwo_update = ? AND
      mandant_id = ?)`,[IN_KJWO_UPDATE,IN_MANDANT_ID,IN_KJWO_UPDATE,IN_KJWO_UPDATE,IN_MANDANT_ID]);
            // ** MSC-ERROR - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
            EXEC(`DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE (mandant_id, art_matching_id, kjwo_update) IN (SELECT
a.mandant_id,
a.matching_id,
a.kjwo_update
FROM dbp_data.sortiment_leistung a
WHERE a.kjwo_update = ? AND
      a.mandant_id = ? AND
      a.umsatz_hr IS NOT NULL AND
      a.listungsaktion = 'Auslistung')`,[IN_KJWO_UPDATE,IN_MANDANT_ID]);
         }
      }
   }
}
 
$$;