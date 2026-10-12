CREATE OR REPLACE PROCEDURE dbp_macro.sp_upd_sortiment_leistung_kmo_java (IN_MANDANT_ID FLOAT
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
, IN_KJWO_UPDATE FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
   var InFunc = function (objectParam) 
    {
      var result = objectParam['inArray'];
      if (objectParam['sqlText'] != '') 
      {
         var res = snowflake.createStatement(
            {
               sqlText : objectParam['sqlText']
            }).execute();
         while ( res.next() ) {
            result.push(res.getColumnValue(1));
         }
      }
      return result.includes(objectParam['inValue']);
   };
{
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
   VAR_MATCHING_ID = IN_MATCHING_ID;
   VAR_ART_ID = IN_ART_ID;
   VAR_GTIN = IN_GTIN;
   VAR_STK_RE_PFLEGE = IN_STK_RE_PFLEGE

   /*
   VAR_STK_RE_PFLEGE = function () {
                                          if (IN_STK_RE_PFLEGE == '') 
                                          {
                                                 return '';
                                          } else 
                                          {
                                                 return IN_STK_RE_PFLEGE;
                                          }
                                   };
   */
   VAR_VORSCHLAG = IN_VORSCHLAG;
   VAR_VORSCHLAG_HR = IN_VORSCHLAG;
   VAR_PRODUKTWISSEN_PFLEGE = IN_LIEFERANTENWISSEN_PFLEGE;
   VAR_LIEFERANTENWISSEN_PFLEGE = IN_LIEFERANTENWISSEN_PFLEGE;
   VAR_LISTUNG_SST_PFLEGE = IN_LISTUNG_SST_PFLEGE;
   VAR_LISTUNG_K_SST_PFLEGE = IN_LISTUNG_K_SST_PFLEGE;
   VAR_KJMO = IN_KJMO;
   VAR_N_K_ARTIKEL = IN_N_K_ARTIKEL;
   VAR_NL_ART_BEZ = IN_NL_ART_BEZ;
   VAR_KJWO_UPDATE = IN_KJWO_UPDATE;
   VAR_SPECIAL_NL = function () {
                                   if (VAR_LISTUNG_SST_PFLEGE != null || VAR_LISTUNG_SST_PFLEGE != ``) 
                                   {
                                          return function () {
                                                               var sql_stmt = `SELECT Cast(? AS INT)`;
                                                               var stmt = snowflake.createStatement({
                                                                      sqlText : sql_stmt,
                                                                      binds : [VAR_LISTUNG_SST_PFLEGE]
                                                               });
                                                               var res = stmt.execute();
                                                               res.next();
                                                               return res.getColumnValue(1);
                                                               };
                                   } else if ((VAR_LISTUNG_K_SST_PFLEGE != null || VAR_LISTUNG_K_SST_PFLEGE != ``) && function () {
                  var sql_stmt = `SELECT
To_Number(Substr(?,2,1))`;
                  var stmt = snowflake.createStatement({
                     sqlText : sql_stmt,
                     binds : [VAR_LISTUNG_K_SST_PFLEGE]
                  });
                  var res = stmt.execute();
                  res.next();
                  return res.getColumnValue(1);
               }() != null) {
            return function () {
               var sql_stmt = `SELECT
Cast(Substr(?,2,1) AS INT)`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [VAR_LISTUNG_K_SST_PFLEGE]
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            };
         } else {
            return 4;
         }
      };
   if ((VAR_LISTUNG_SST_PFLEGE == null || VAR_LISTUNG_SST_PFLEGE == ``) && (VAR_LISTUNG_K_SST_PFLEGE == null || VAR_LISTUNG_K_SST_PFLEGE == ``) && (VAR_PRODUKTWISSEN_PFLEGE == null || VAR_PRODUKTWISSEN_PFLEGE == ``) && (VAR_LIEFERANTENWISSEN_PFLEGE == null || VAR_LIEFERANTENWISSEN_PFLEGE == ``) && (VAR_VORSCHLAG == `` || VAR_VORSCHLAG == null)) {
      VAR_NL_ART_BEZ = nl_art_bez;
   } else {
      if (VAR_GTIN == null || VAR_GTIN != null && !InFunc({
               sqlText : '',
               inArray : [`-9999`,`-9998`],
               inValue : VAR_GTIN
            })) {
         if (VAR_VORSCHLAG == `Zurücksetzen`) {
            var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET  A411_stk_rohertrag_pflege = NULL
,A50_listungsaktion = NULL
,A51_listung_sst_pflege = NULL
,A52_listung_k_sst_pflege = NULL
,A412_umsatz_brutto_hochrechnung = NULL
,A413_absatz_hochrechnung = NULL
,A414_rohertrag_hochrechnung = NULL
WHERE matching_id = ? AND A425_kjmo = ? AND mandant_id = ? AND A500_kjwo_update = ?`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]
            }).execute();
            var sql_stmt = `DELETE FROM dbp_msi_data.erwartete_entwicklung
WHERE matching_id = ? AND
      kjmo = ? AND
      mandant_id = ?`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID]
            }).execute();
         } else if (VAR_VORSCHLAG == `Keine Veränderung setzen`) {
            var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET A411_stk_rohertrag_pflege = NULL
,A50_listungsaktion = 'Keine Veränderung'
,A51_listung_sst_pflege = NULL
,A52_listung_k_sst_pflege = NULL
,A412_umsatz_brutto_hochrechnung = NULL
,A413_absatz_hochrechnung = NULL
,A414_rohertrag_hochrechnung = NULL
WHERE matching_id = ? AND A425_kjmo = ? AND mandant_id = ? AND A500_kjwo_update = ? AND (A50_listungsaktion IS NULL OR A50_listungsaktion = '')`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]
            }).execute();
         } else if (VAR_VORSCHLAG == `Keine Veränderung`) {
            var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET  A411_stk_rohertrag_pflege = NULL
,A50_listungsaktion = 'Keine Veränderung'
,A51_listung_sst_pflege = NULL
,A52_listung_k_sst_pflege = NULL
,A412_umsatz_brutto_hochrechnung = NULL
,A413_absatz_hochrechnung = NULL
,A414_rohertrag_hochrechnung = NULL
WHERE matching_id = ? AND A425_kjmo = ? AND mandant_id = ? AND A500_kjwo_update = ?`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]
            }).execute();
         } else if (VAR_VORSCHLAG == `Keine Veränderung zurücksetzen`) {
            var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET  A50_listungsaktion = NULL
WHERE matching_id = ? AND A425_kjmo = ? AND mandant_id = ? AND A500_kjwo_update = ? AND A50_listungsaktion = 'Keine Veränderung'`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]
            }).execute();
         } else {
            if (InFunc({
               sqlText : '',
               inArray : [`Wiedereinlistung`,`Neulistung KL-Artikel`,`Einlistung`],
               inValue : VAR_VORSCHLAG_HR
            })) {
               VAR_VORSCHLAG_HR = `Listung erweitern`;
            }
            if (InFunc({
               sqlText : '',
               inArray : [`Einlistung Potenzial`],
               inValue : VAR_VORSCHLAG_HR
            })) {
               VAR_VORSCHLAG_HR = `Einlistung Potenzialartikel`;
            }
            if ((VAR_LISTUNG_SST_PFLEGE == `` || VAR_LISTUNG_SST_PFLEGE == null) && (VAR_LISTUNG_K_SST_PFLEGE == `` || VAR_LISTUNG_K_SST_PFLEGE == null)) {
               VAR_VORSCHLAG_HR = `Auslistung`;
            }
            var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET  A411_stk_rohertrag_pflege = ?
,A51_listung_sst_pflege = Trim(?)
,A52_listung_k_sst_pflege = Trim(?)
,A50_listungsaktion = ?
WHERE matching_id = ? AND A425_kjmo = ? AND mandant_id = ? AND A500_kjwo_update = ?`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_STK_RE_PFLEGE, IN_LISTUNG_SST_PFLEGE, VAR_LISTUNG_K_SST_PFLEGE, IN_VORSCHLAG, IN_MATCHING_ID, IN_KJMO,IN_MANDANT_ID,IN_KJWO_UPDATE]
            }).execute();
            if (VAR_LISTUNG_SST_PFLEGE != `` && VAR_LISTUNG_SST_PFLEGE != null || VAR_LISTUNG_K_SST_PFLEGE != `` && VAR_LISTUNG_K_SST_PFLEGE != null || VAR_VORSCHLAG_HR == `Auslistung`) 
            {
               if (InFunc({
                  sqlText : '',
                  inArray : [`Auslistung`],
                  inValue : VAR_VORSCHLAG_HR
               })) {
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
               var sql_stmt = `INSERT INTO dbp_msi_data.sortiment_art_kmo (mandant_id,
art_id,
gtin_id,
status,
kjwo_update)SELECT
a.mandant_id,
a.art_id,
Max(CAST(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30))) AS gtin_id,
Max(a.status) AS status,
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
 GROUP BY 1,2`;
               snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID]
               }).execute();




               //------------------------------------------------------------------------------------------------------
               //   (I) UPDATE FUER SORTIMENT_LEISTUNG (K-Stufen)
               //------------------------------------------------------------------------------------------------------

               

               var sql_stmt = `UPDATE dbp_msi_data.tupel_mat 
                               SET A412_umsatz_brutto_hochrechnung = x2.umsatz,
                                   A413_absatz_hochrechnung = x2.absatz,
                                   A414_rohertrag_hochrechnung = x2.rohertrag,
                                   A50_listungsaktion = CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE x2.vorschlag END 
                                                                 -- b1
                                   FROM (SELECT
                                                 CASE
                                                    WHEN
                                                          CASE
                                                               WHEN Max(x.vorschlag_) <> 'dynamic' THEN Max(x.vorschlag_)
                                                               WHEN Sum(x.anzahl_reduktion) = 0 AND Sum(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) > Sum(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) < Sum(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                                               ELSE 'SOLL-Listung = IST-Listung'
                                                          END = 'SOLL-Listung = IST-Listung'
                                                    THEN 0
                                                    ELSE Coalesce(Sum(x.umsatz_)/CASE WHEN Max(x.status) = 'G' THEN 1 ELSE Count(DISTINCT x.art_id) END,0)
                                                 END AS umsatz,
                                                 CASE
                                                   WHEN
                                                        CASE
                                                               WHEN Max(x.vorschlag_) <> 'dynamic' THEN Max(x.vorschlag_)
                                                               WHEN Sum(x.anzahl_reduktion) = 0 AND Sum(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) > Sum(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) < Sum(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                                               ELSE 'SOLL-Listung = IST-Listung'
                                                        END = 'SOLL-Listung = IST-Listung'
                                                   THEN 0
                                                   ELSE Coalesce(Sum(x.absatz_)/CASE WHEN Max(x.status) = 'G' THEN 1 ELSE Count(DISTINCT x.art_id) END,0)
                                                 END AS absatz,
                                                 CASE
                                                   WHEN
                                                        CASE
                                                               WHEN Max(x.vorschlag_) <> 'dynamic' THEN Max(x.vorschlag_)
                                                               WHEN Sum(x.anzahl_reduktion) = 0 AND Sum(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) > Sum(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) < Sum(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                                               WHEN Sum(x.anzahl_reduktion) > 0 AND Sum(x.anzahl_erweiterung) > 0 AND Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) AND Sum(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                                               WHEN Sum(x.anzahl_reduktion) = Sum(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                                               ELSE 'SOLL-Listung = IST-Listung'
                                                        END = 'SOLL-Listung = IST-Listung'
                                                   THEN 0
                                                   ELSE Coalesce(Sum(x.rohertrag_)/CASE WHEN Max(x.status) = 'G' THEN 1 ELSE Count(DISTINCT x.art_id) END,0)
                                                 END AS rohertrag,
                                                 Sum(x.anzahl_reduktion) AS anzahl_reduktion_,
                                                 Sum(x.anzahl_erweiterung) AS anzahl_erweiterung_,
                                                 Max(x.vorschlag_) AS vorschlag__,
                                                 CASE
                                                        WHEN vorschlag__ <> 'dynamic' THEN vorschlag__
                                                        WHEN anzahl_reduktion_ = 0 AND anzahl_erweiterung_ > 0 THEN 'Listung erweitern'
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ = 0 THEN 'Listung reduzieren'
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ > anzahl_erweiterung_ THEN 'Listung reduzieren und erweitern'
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ < anzahl_erweiterung_ THEN 'Listung erweitern und reduzieren'
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ = anzahl_erweiterung_ AND Sum(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                                        WHEN anzahl_reduktion_ > 0 AND anzahl_erweiterung_ > 0 AND anzahl_reduktion_ = anzahl_erweiterung_ AND Sum(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                                        WHEN anzahl_reduktion_ = anzahl_erweiterung_ THEN 'SOLL-Listung = IST-Listung'
                                                        ELSE 'SOLL-Listung = IST-Listung'
                                                 END AS vorschlag
                                          FROM (-- K-Sicht fuer KL (SST)
                                                 SELECT a.mandant_id,
                                                        a.art_id,
                                                        Max(b.status) AS status,
                                                        Min(a.list_kz) AS list_kz_,
                                                        Sum(a.umsatz_hr) AS umsatz_,
                                                        Sum(a.absatz_hr) AS absatz_,
                                                        Sum(a.rohertrag_hr) AS rohertrag_,
                                                        CAST(0 AS INT) AS anzahl_reduktion,
                                                        Sum(erweiterung_fg) AS anzahl_erweiterung,
                                                        CASE 
                                                           WHEN ? = 'Auslistung' THEN 'Auslistung' 
                                                                --b2
                                                           WHEN list_kz_ IN ('B','C1','C2','D1','D2') THEN 'Einlistung Kauflandartikel' ELSE'dynamic' 
                                                        END AS vorschlag_
                                                 FROM dbp_msi_data.kl_listung_kmo a
                                                 JOIN dbp_msi_data.sortiment_art_kmo b
                                                        ON a.mandant_id = b.mandant_id AND
                                                        a.art_id = b.art_id AND
                                                        a.kjwo_update = b.kjwo_update
                                                 WHERE (a.mandant_id,a.art_id) NOT IN (SELECT
                                                                                           mandant_id,
                                                                                           art_id
                                                                                       FROM dbp_etl.not_listed_basis_kmo
                                                                                      ) 
                                                   AND a.listung_art = 'Listung erweitern' AND
                                                        a.kjwo_update = ? AND
                                                                        --b3
                                                        a.mandant_id = ? AND
                                                                       --b4
                                                        a.sm_id_selected = Cast(? AS INT) AND
                                                                                --b5
                                                        a.ksm_id IS NULL
                                          GROUP BY 1,2
                                          UNION ALL
                                          SELECT
                                                 a.mandant_id,
                                                 a.art_id,
                                                 Max(b.status) AS status,
                                                 Min(a.list_kz) AS list_kz_,
                                                 Sum(a.umsatz_hr) AS umsatz_,
                                                 Sum(a.absatz_hr) AS absatz_,
                                                 Sum(a.rohertrag_hr) AS rohertrag_,
                                                 Sum(reduktion_fg) AS anzahl_reduktion,
                                                 CAST(0 AS INT) AS anzahl_erweiterung,
                                                 CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                                                           --b6
                                          FROM dbp_msi_data.kl_listung_kmo a
                                          JOIN dbp_msi_data.sortiment_art_kmo b
                                          ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                                          WHERE (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,
                                                                                       art_id
                                                                                FROM dbp_etl.not_listed_basis_kmo
                                                                             ) 
                                             AND a.listung_art = 'Listung reduzieren' AND
                                                 a.kjwo_update = ? AND
                                                                 --b7
                                                 a.mandant_id = ? AND
                                                                --b8
                                                 a.sm_id_selected = Cast(? AS INT) AND
                                                                         --b9
                                                 a.sm_id < Cast(? AS INT) AND
                                                                --b10
                                                 a.ksm_id IS NULL
                                          GROUP BY 1,2
                                          UNION ALL
                                          SELECT a.mandant_id,
                                                 a.art_id,
                                                 Max(b.status) AS status,
                                                 Min(a.list_kz) AS list_kz_,
                                                 Sum(a.umsatz_hr) AS umsatz_,
                                                 Sum(a.absatz_hr) AS absatz_,
                                                 Sum(a.rohertrag_hr) AS rohertrag_,
                                                 CAST(0 AS INT) AS anzahl_reduktion,
                                                 Sum(erweiterung_fg) AS anzahl_erweiterung,
                                                 CASE WHEN ? = 'Auslistung' THEN 'Auslistung' WHEN list_kz_ IN ('B','C1','C2','D1','D2') THEN'Einlistung Kauflandartikel' ELSE'dynamic' END AS vorschlag_
                                                           --b11
                                          FROM dbp_msi_data.kl_listung_kmo a
                                          JOIN dbp_msi_data.sortiment_art_kmo b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                                          WHERE (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,
                                                                                       art_id
                                                                                FROM dbp_etl.not_listed_basis_kmo
                                                                              ) 
                                            AND a .listung_art = 'Listung erweitern' AND
                                                 a.kjwo_update = ? AND
                                                                 --b12
                                                 a.mandant_id = ? AND
                                                               -- b13
                                                 Trim(a.ksm_id_selected) = Trim(?) AND
                                                                                --b14
                                                 a.sm_id IS NULL
                                          GROUP BY 1,2
                                          UNION ALL
                                          SELECT a.mandant_id,
                                                 a.art_id,
                                                 Max(b.status) AS status,
                                                 Min(a.list_kz) AS list_kz_,
                                                 Sum(a.umsatz_hr) AS umsatz_,
                                                 Sum(a.absatz_hr) AS absatz_,
                                                 Sum(a.rohertrag_hr) AS rohertrag_,
                                                 Sum(reduktion_fg) AS anzahl_reduktion,
                                                 CAST(0 AS INT) AS anzahl_erweiterung,
                                                 CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                                                           --b15
                                          FROM dbp_msi_data.kl_listung_kmo a
                                          JOIN dbp_msi_data.sortiment_art_kmo b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                                          WHERE (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,
                                                                                       art_id
                                                                                FROM dbp_etl.not_listed_basis_kmo
                                                                               ) 
                                            AND  a.listung_art = 'Listung reduzieren' AND
                                                 a.kjwo_update = ? AND
                                                                 --b16
                                                 a.mandant_id = ? AND
                                                                --b17
                                                 Trim(a.ksm_id_selected) = Trim(?) AND
                                                                                --b18
                                                 Cast(Substr(Trim(a.ksm_id),2,1) AS INT) < Cast(Substr(Trim(?),2,1) AS INT) AND
                                                                                                            --b19
                                                 a.sm_id IS NULL
                                          GROUP BY 1,2
                                          UNION ALL
                                          SELECT
                                                 a.mandant_id,
                                                 a.art_id,
                                                 Max(b.status) AS status,
                                                 Min(a.list_kz) AS list_kz_,
                                                 Sum(a.umsatz_hr) AS umsatz_,
                                                 Sum(a.absatz_hr) AS absatz_,
                                                 Sum(a.rohertrag_hr) AS rohertrag_,
                                                 Sum(reduktion_fg) AS anzahl_reduktion,
                                                 CAST(0 AS INT) AS anzahl_erweiterung,
                                                 CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                                                           --b20
                                          FROM dbp_msi_data.kl_listung_kmo a
                                          JOIN dbp_msi_data.sortiment_art_kmo b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                                          WHERE (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,
                                                                                       art_id
                                                                                 FROM dbp_etl.not_listed_basis_kmo
                                                                               ) 
                                            AND  a.listung_art = 'Auslistung' AND
                                                 a.kjwo_update = ? AND
                                                                 --b21
                                                 a.mandant_id = ? AND
                                                                -- b22
                                                 a.sm_id_selected = Cast(? AS INT) AND
                                                                         --b23
                                                 a.ksm_id IS NULL
                                          GROUP BY 1,2
                                          UNION ALL
                                          SELECT a.mandant_id,
                                                 a.art_id,
                                                 Max(b.status) AS status,
                                                 Min(a.list_kz) AS list_kz_,
                                                 Sum(a.umsatz_hr) AS umsatz_,
                                                 Sum(a.absatz_hr) AS absatz_,
                                                 Sum(a.rohertrag_hr) AS rohertrag_,
                                                 Sum(reduktion_fg) AS anzahl_reduktion,
                                                 CAST(0 AS INT) AS anzahl_erweiterung,
                                                 CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                                                           --b24
                                          FROM dbp_msi_data.kl_listung_kmo a
                                          JOIN dbp_msi_data.sortiment_art_kmo b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                                          WHERE (a.mandant_id,a.art_id) NOT IN (SELECT mandant_id,
                                                                                       art_id
                                                                                FROM dbp_etl.not_listed_basis_kmo) 
                                            AND  a.listung_art = 'Auslistung' AND
                                                 a.kjwo_update = ? AND
                                                                 --b25
                                                 a.mandant_id = ? AND
                                                                 --b26
                                                 Trim(a.ksm_id_selected) = Trim(?) AND
                                                                                --b27
                                                 a.sm_id IS NULL
                                          GROUP BY 1,2
                                          UNION ALL
                                          SELECT a.mandant_id,
                                                 1 AS art_id,
                                                 'N' AS status,
                                                 'A' AS list_kz,
                                                 Sum(a.umsatz_hr) AS umsatz_,
                                                 Sum(a.absatz_hr) AS absatz_,
                                                 Sum(a.absatz_hr)*Cast(REPLACE(?,',','.') AS FLOAT) AS rohertrag_,
                                                                               --b28
                                                 CAST(0 AS INT) AS anzahl_reduktion,
                                                 Count(*) AS anzahl_erweiterung,
                                                 'Einlistung Potenzialartikel' AS vorschlag_
                                          FROM dbp_msi_data.nl_listung_kmo a
                                          WHERE a.gtin NOT IN (SELECT CAST(Cast(gtin_id AS BIGINT) AS VARCHAR(30))
                                                               FROM dbp_etl.not_listed_basis_kmo
                                                             ) 
                                            AND  a.gtin = ? AND
                                                          --b29
                                                 a.listung_art = 'Einlistung Potenzialartikel' AND
                                                 a.kjwo_update = ? AND
                                                                 --b30
                                                 a.art_nielsen_bez = ? AND
                                                                     --b31
                                                 a.sm_id_selected = ?
                                                                    b32
                                          GROUP BY 1,2
                                    ) 
                              x) x2
                            WHERE (art_id = ? AND A425_kjmo = ? AND mandant_id = ?  -- b(33,34,35)
                              AND A500_kjwo_update = ?) OR (gtin = ? AND A425_kjmo = ? -- b(36,37,38)
                              AND mandant_id = ? AND nielsen_art_bez = ? -- b (39,40)
                              AND A500_kjwo_update = ?)`; 
               snowflake.createStatement({
                  sqlText : sql_stmt,
                     binds : [VAR_VORSCHLAG_HR,
                             VAR_VORSCHLAG_HR,
                             IN_KJWO_UPDATE,
                             IN_MANDANT_ID,
                             VAR_LISTUNG_SST_PFLEGE,
                             VAR_VORSCHLAG_HR,
                             IN_KJWO_UPDATE
                            ,IN_MANDANT_ID,
                             VAR_LISTUNG_SST_PFLEGE,
                             VAR_LISTUNG_SST_PFLEGE,
                             VAR_VORSCHLAG_HR,
                             IN_KJWO_UPDATE,
                             IN_MANDANT_ID,
                             VAR_LISTUNG_K_SST_PFLEGE
                            ,VAR_VORSCHLAG_HR,
                            IN_KJWO_UPDATE,
                            IN_MANDANT_ID,
                            VAR_LISTUNG_K_SST_PFLEGE,
                            VAR_LISTUNG_K_SST_PFLEGE,
                            VAR_VORSCHLAG_HR,
                            IN_KJWO_UPDATE
                            ,IN_MANDANT_ID,
                            VAR_LISTUNG_SST_PFLEGE,
                            VAR_VORSCHLAG_HR,
                            IN_KJWO_UPDATE,
                            IN_MANDANT_ID,
                            VAR_LISTUNG_K_SST_PFLEGE,
                            VAR_STK_RE_PFLEGE
                            ,IN_GTIN,
                            IN_KJWO_UPDATE,
                            IN_NL_ART_BEZ,
                            VAR_SPECIAL_NL,
                            IN_ART_ID,
                            IN_KJMO,
                            IN_MANDANT_ID,
                            IN_KJWO_UPDATE,
                            IN_GTIN,
                            IN_KJMO,
                            IN_MANDANT_ID
                            ,IN_NL_ART_BEZ,
                            IN_KJWO_UPDATE]
               }).execute();

               return 999
               var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET A50_listungsaktion = z.A50_listungsaktion FROM (SELECT
CASE
                                                              WHEN A50_listungsaktion = 'Auslistung'
                                                              THEN A50_listungsaktion
                                                              WHEN (A51_listung_sst_pflege <> 'N/A' OR  A52_listung_k_sst_pflege <> 'N/A') AND
                                                                    A449_anz_maerkte_k_sst = 0 AND A59_anz_maerkte_sst = 0 AND
                                                                    anz_maerkte_baustein_sonstige = 0 AND
                                                                    A57_anz_maerkte_listung_einzel = 0 AND
                                                                    A53_anz_maerkte_listung_gesamt = 0
                                                              THEN 'Einlistung Kauflandartikel'
                                                              ELSE A50_listungsaktion
                                                            END AS A50_listungsaktion
FROM dbp_msi_data.tupel_mat
                                                     WHERE mandant_id = ? AND
                                                           art_id IS NOT NULL AND
                                                           A425_kjmo = ? AND
                                                           A500_kjwo_update = ? AND
                                                           matching_id = ?) z

WHERE dbp_msi_data.tupel_mat.mandant_id = ? AND
      dbp_msi_data.tupel_mat.A425_kjmo = ? AND
      dbp_msi_data.tupel_mat.A500_kjwo_update = ? AND
      dbp_msi_data.tupel_mat.matching_id = ?`;
               snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_MANDANT_ID,IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID,IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID]
               }).execute();
               

               //------------------------------------------------------------------------------------------------------
               //   (II) INSERT FUER ERWARTETE ENTWICKLUNG (K-Stufen)
               //------------------------------------------------------------------------------------------------------
               if (!InFunc({
                  sqlText : '',
                  inArray : `Keine Veränderung` || VAR_VORSCHLAG_HR == null,
                  inValue : VAR_VORSCHLAG_HR
               })) {
                  var sql_stmt = `DELETE FROM dbp_msi_data.erwartete_entwicklung
WHERE matching_id = ? AND
      kjmo = ? AND
      mandant_id = ?`;
                  snowflake.createStatement({
                     sqlText : sql_stmt,
                     binds : [IN_MATCHING_ID,IN_KJMO,IN_MANDANT_ID]
                  }).execute();
                  
                  var sql_stmt = `INSERT INTO dbp_msi_data.erwartete_entwicklung (mandant_id
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
,rohertrag_hr)SELECT
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
Coalesce(Sum(x3.umsatz_)/CASE WHEN Max(x3.status) = 'G' THEN 1 ELSE Count(DISTINCT x3.art_id) END,0) AS umsatz,
Coalesce(Sum(x3.absatz_)/CASE WHEN Max(x3.status) = 'G' THEN 1 ELSE Count(DISTINCT x3.art_id) END,0) AS absatz,
Coalesce(Sum(x3.rohertrag_)/CASE WHEN Max(x3.status) = 'G' THEN 1 ELSE Count(DISTINCT x3.art_id) END,0) AS rohertrag
FROM (-- K-Sicht fuer KL (SST)
SELECT
? AS mandant_id,
? AS matching_id,
a4.sm_id,
'  ' AS ksm_id,
a4.art_id,
Max(b4.status) AS status,
Sum(a4.umsatz_hr) AS umsatz_,
Sum(a4.absatz_hr) AS absatz_,
Sum(a4.rohertrag_hr) AS rohertrag_
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
                     a4.sm_id_selected = Cast(? AS INT) AND
                     a4.ksm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
UNION ALL
SELECT
? AS mandant_id,
? AS matching_id,
a4.sm_id,
'  ' AS ksm_id,
a4.art_id,
Max(b4.status) AS status,
Sum(a4.umsatz_hr) AS umsatz_,
Sum(a4.absatz_hr) AS absatz_,
Sum(a4.rohertrag_hr) AS rohertrag_
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
                     a4.sm_id_selected = Cast(? AS INT) AND
                     a4.sm_id < Cast(? AS INT) AND
                     a4.ksm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
SELECT
? AS mandant_id,
? AS matching_id,
-1 AS sm_id,
Trim(a4.ksm_id) AS ksm_id,
a4.art_id,
Max(b4.status) AS status,
Sum(a4.umsatz_hr) AS umsatz_,
Sum(a4.absatz_hr) AS absatz_,
Sum(a4.rohertrag_hr) AS rohertrag_
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
                     Trim(a4.ksm_id_selected) = Trim(?) AND
                     a4.sm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
SELECT
? AS mandant_id,
? AS matching_id,
-1 AS sm_id,
Trim(a4.ksm_id) AS ksm_id,
a4.art_id,
Max(b4.status) AS status,
Sum(a4.umsatz_hr) AS umsatz_,
Sum(a4.absatz_hr) AS absatz_,
Sum(a4.rohertrag_hr) AS rohertrag_
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
                     Trim(a4.ksm_id_selected) = Trim(?) AND
                     Cast(Substr(Trim(a4.ksm_id),2,1) AS INT) < Cast(Substr(Trim(?),2,1) AS INT) AND
                     a4.sm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
SELECT
? AS mandant_id,
? AS matching_id,
-1 AS sm_id,
Trim(a4.ksm_id) AS ksm_id,
a4.art_id,
Max(b4.status) AS status,
Sum(a4.umsatz_hr) AS umsatz_,
Sum(a4.absatz_hr) AS absatz_,
Sum(a4.rohertrag_hr) AS rohertrag_
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
                     Trim(a4.ksm_id_selected) = Trim(?) AND
                     a4.sm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0
              UNION ALL
SELECT
? AS mandant_id,
? AS matching_id,
a4.sm_id,
'  ' AS ksm_id,
a4.art_id,
Max(b4.status) AS status,
Sum(a4.umsatz_hr) AS umsatz_,
Sum(a4.absatz_hr) AS absatz_,
Sum(a4.rohertrag_hr) AS rohertrag_
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
                     a4.sm_id_selected = Cast(? AS INT) AND
                     a4.ksm_id IS NULL
              GROUP BY 1,2,3,4,5
              HAVING umsatz_ <> 0) x3
        JOIN (SELECT
mandant_id,
art_matching_id,
Max(kl_wg_id) AS kl_wg_id,
Max(kl_owg_id) AS kl_owg_id,
Max(kl_uwg_id) AS kl_uwg_id
FROM dbp_etl.art_matching_nielsen_per_kmo
GROUP BY 1,2) y3
ON x3.matching_id = y3.art_matching_id AND
x3.mandant_id = y3.mandant_id
JOIN dbp_data.mandant z3
ON ? = z3.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13`;
                  snowflake.createStatement({
                     sqlText : sql_stmt,
                     binds : [IN_MANDANT_ID,IN_KJMO,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,VAR_LISTUNG_SST_PFLEGE,IN_MANDANT_ID,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,VAR_LISTUNG_SST_PFLEGE,VAR_LISTUNG_SST_PFLEGE,IN_MANDANT_ID,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,VAR_LISTUNG_K_SST_PFLEGE,IN_MANDANT_ID,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,VAR_LISTUNG_K_SST_PFLEGE,VAR_LISTUNG_K_SST_PFLEGE,IN_MANDANT_ID,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,VAR_LISTUNG_K_SST_PFLEGE,IN_MANDANT_ID,IN_MATCHING_ID,IN_KJWO_UPDATE,IN_MANDANT_ID,VAR_LISTUNG_SST_PFLEGE,IN_MANDANT_ID]
                  }).execute();
               }

               
               var sql_stmt = `DELETE FROM dbp_msi_data.sortiment_art_kmo
WHERE (mandant_id,art_id,gtin_id,kjwo_update) IN (SELECT
a.mandant_id,
a.art_id,
CAST(Cast(a.gtin_id AS BIGINT) AS VARCHAR(30)) AS gtin_id,
? AS kjwo_update
FROM dbp_etl.art_matching_nielsen_per_kmo a
WHERE a.art_matching_id = ? AND
      a.mandant_id = ?
GROUP BY 1,2,3)`;
               snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID]
               }).execute();
            }
         }
         if (VAR_VORSCHLAG == `Zurücksetzen`) {
            var sql_stmt = `DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE kjmo = ? AND
      kjwo_update = ? AND
      art_matching_id = ? AND
      mandant_id = ?`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID]
            }).execute();

            
            var sql_stmt = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu SELECT
*
FROM dbp_data.art_kl_preislage_zu_per
  WHERE kjmo = ? AND
        kjwo_update = ? AND
        art_matching_id = ? AND
        mandant_id = ?`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_KJMO,IN_KJWO_UPDATE,IN_MATCHING_ID,IN_MANDANT_ID]
            }).execute();
         } else {
            var sql_stmt = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
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
,menge_sa)SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.A425_kjmo,
a.A500_kjwo_update,
x.default_wrg AS wrg_id,
Trim(Cast(b.k AS VARCHAR(10))) AS sm_id,
'' AS ksm_id,
a.A5_owg_id,
a.A7_wg_id,
a.wug_id,
a.A31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
a.A34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_msi_data.tupel_mat a
JOIN dbp_data.art_kl_preislage_zu_per_neu c
ON a.mandant_id = c.mandant_id AND
   a.A425_kjmo = c.kjmo AND
   a.matching_id = c.art_matching_id AND
   a.A39_listung_sst_mvke = c.sm_id
JOIN (SELECT
wtag_id AS k
FROM dbp_data.tag
     WHERE wtag_id BETWEEN 1 AND 5
     GROUP BY 1) b
 ON TO_NUMBER(Trim(a.A51_listung_sst_pflege)) <= b.k AND
b.k < CASE
        WHEN a.A39_listung_sst_mvke = 'N/A'
        THEN 6
        ELSE Cast(a.A39_listung_sst_mvke AS INT)
      END
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.A412_umsatz_brutto_hochrechnung IS NOT NULL AND
    a.mandant_id = ? AND
    a.A425_kjmo IN (SELECT
kjmo
FROM dbp_data.monat
                WHERE kjmo = ?) AND
     a.A50_listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND
    (a.mandant_id,a.matching_id,a.A425_kjmo,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjmo,
Cast(sm_id AS INT)
FROM dbp_data.art_kl_preislage_zu_per_neu
                                                     WHERE sm_id NOT IN ('N/A','-1') AND
                                                           mandant_id = ?)`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MANDANT_ID,IN_KJMO,IN_MANDANT_ID]
            }).execute();

            
            var sql_stmt = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
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
,menge_sa)SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.A425_kjmo,
a.A500_kjwo_update,
x.default_wrg AS wrg_id,
Trim(Cast(b.k AS VARCHAR(10))) AS sm_id,
'' AS ksm_id,
a.A5_owg_id,
a.A7_wg_id,
a.wug_id,
a.A31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
a.A34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_msi_data.tupel_mat a
JOIN dbp_data.art_kl_preislage_zu_per_neu c
ON a.mandant_id = c.mandant_id AND
   a.A425_kjmo = c.kjmo AND
   a.matching_id = c.art_matching_id AND
   a.A38_listung_k_sst_mvke = c.ksm_id
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
     WHERE akt_tag BETWEEN 1 AND 9
     GROUP BY 1) b
 ON TO_NUMBER(Trim(Substr(a.A52_listung_k_sst_pflege,2,1))) <= b.k AND
b.k < CASE
        WHEN a.A38_listung_k_sst_mvke = 'N/A'
        THEN 10
        ELSE Cast(Substr(a.A38_listung_k_sst_mvke,2,1) AS INT)
      END
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.A412_umsatz_brutto_hochrechnung IS NOT NULL AND
    a.mandant_id = ? AND
    a.A425_kjmo IN (SELECT
kjmo
FROM dbp_data.monat
                WHERE kjmo = ?) AND
     a.A50_listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND
    (a.mandant_id,a.matching_id,a.A425_kjmo,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjmo,
Cast(Substr(ksm_id,2,1) AS INT)
FROM dbp_data.art_kl_preislage_zu_per_neu
                                                     WHERE ksm_id NOT IN ('') AND
                                                           mandant_id = ?)`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MANDANT_ID,IN_KJMO,IN_MANDANT_ID]
            }).execute();
            var sql_stmt = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
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
,menge_sa)SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.A425_kjmo,
a.A500_kjwo_update,
x.default_wrg AS wrg_id,
-1 AS sm_id,
'K'||Trim(Cast(b.k AS VARCHAR(10))) AS ksm_id,
a.A5_owg_id,
a.A7_wg_id,
a.wug_id,
a.A31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
a.A34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_msi_data.tupel_mat a
JOIN dbp_data.art_kl_preislage_zu_per_neu c
ON a.mandant_id = c.mandant_id AND
   a.A500_kjwo_update = c.kjwo_update AND
   a.matching_id = c.art_matching_id AND
   a.A38_listung_k_sst_mvke = c.ksm_id
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
     WHERE akt_tag BETWEEN 1 AND 9
     GROUP BY 1) b
 ON TO_NUMBER(Trim(Substr(Coalesce(a.A52_listung_k_sst_pflege,'K9'),2,1))) <= b.k AND
b.k < Cast(Substr(Coalesce(a.A38_listung_k_sst_mvke,'K9'),2,1) AS INT)
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.A412_umsatz_brutto_hochrechnung IS NOT NULL AND
    a.mandant_id = ? AND
    a.A500_kjwo_update = ? AND
    a.A50_listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND
   (a.mandant_id,a.matching_id,a.A500_kjwo_update,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjwo_update,
Cast(Substr(ksm_id,2,1) AS INT)
FROM dbp_data.art_kl_preislage_zu_per_neu
                                                            WHERE ksm_id IS NOT NULL AND
                                                                  ksm_id <> '' AND
                                                                  kjwo_update = ? AND
                                                                  mandant_id = ?)`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_MANDANT_ID,IN_KJWO_UPDATE,IN_KJWO_UPDATE,IN_MANDANT_ID]
            }).execute();
            var sql_stmt = `DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE (mandant_id,art_matching_id,kjmo,ksm_id,kjwo_update) IN (SELECT
a.mandant_id,
a.matching_id,
a.A425_kjmo,
'K'||Cast(b.k AS VARCHAR(10)),
a.A500_kjwo_update
FROM dbp_msi_data.tupel_mat a
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
                                                                   WHERE akt_tag BETWEEN 1 AND 9
                                                                   GROUP BY 1) b
                                                               ON Cast(Substr(Coalesce(a.A52_listung_k_sst_pflege,'K9'),2,1) AS INT) > b.k AND
                                                                  b.k <= Cast(Substr(Coalesce(a.A38_listung_k_sst_mvke,'K9'),2,1) AS INT)
                                                             WHERE a.A500_kjwo_update = ? AND
                                                                   a.A412_umsatz_brutto_hochrechnung IS NOT NULL AND
                                                                   a.mandant_id = ? AND
                                                                   a.A50_listungsaktion IN ('Listung reduzieren','Listung reduzieren und erweitern','Listung erweitern und reduzieren'))`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_KJWO_UPDATE,IN_MANDANT_ID]
            }).execute();
            var sql_stmt = `INSERT INTO dbp_data.art_kl_preislage_zu_per_neu (mandant_id
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
,menge_sa)SELECT
a.mandant_id,
a.matching_id AS art_matching_id,
a.A425_kjmo,
a.A500_kjwo_update,
x.default_wrg AS wrg_id,
-1 AS sm_id,
'K'||Trim(Cast(b.k AS VARCHAR(10))) AS ksm_id,
a.A5_owg_id,
a.A7_wg_id,
a.wug_id,
a.A31_vk_brutto_kl_pk_1 AS vk_brutto_pk_1,
a.A34_vk_brutto_durchschnitt_nielsen AS durchschnitt_preis_kasse,
c.umsatz_brutto,
c.umsatz_brutto_af,
c.umsatz_brutto_sa,
c.menge,
c.menge_af,
c.menge_sa
FROM dbp_msi_data.tupel_mat a
JOIN dbp_data.art_nielsen_preislage_zu_per c
ON a.mandant_id = c.mandant_id AND
   a.A425_kjmo = c.kjmo AND
 a.matching_id = c.art_matching_id AND
 a.A500_kjwo_update = ?
JOIN (SELECT
akt_tag AS k
FROM dbp_data.tag
     WHERE akt_tag BETWEEN 1 AND 9
     GROUP BY 1) b
 ON TO_NUMBER(Trim(Substr(Coalesce(a.A52_listung_k_sst_pflege,'K9'),2,1))) <= b.k
JOIN dbp_data.mandant x
ON a.mandant_id = x.mandant_id
WHERE a.A412_umsatz_brutto_hochrechnung IS NOT NULL AND
    a.mandant_id = ? AND
    a.A500_kjwo_update = ? AND
    a.A50_listungsaktion = 'Einlistung Potenzialartikel' AND
   (a.mandant_id,a.matching_id,a.A500_kjwo_update,b.k) NOT IN (SELECT
mandant_id,
art_matching_id,
kjwo_update,
Cast(Substr(ksm_id,2,1) AS INT)
FROM dbp_data.art_kl_preislage_zu_per_neu
                                                            WHERE ksm_id IS NOT NULL AND
                                                                  ksm_id <> '' AND
                                                                  kjwo_update = ? AND
                                                                  mandant_id = ?)`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_KJWO_UPDATE,IN_MANDANT_ID,IN_KJWO_UPDATE,IN_KJWO_UPDATE,IN_MANDANT_ID]
            }).execute();
            var sql_stmt = `DELETE FROM dbp_data.art_kl_preislage_zu_per_neu
WHERE (mandant_id, art_matching_id, kjwo_update) IN (SELECT
a.mandant_id,
a.matching_id,
a.A500_kjwo_update
FROM dbp_msi_data.tupel_mat a
WHERE a.A500_kjwo_update = ? AND
      a.mandant_id = ? AND
      a.A412_umsatz_brutto_hochrechnung IS NOT NULL AND
      a.A50_listungsaktion = 'Auslistung')`;
            snowflake.createStatement({
               sqlText : sql_stmt,
               binds : [IN_KJWO_UPDATE,IN_MANDANT_ID]
            }).execute();
         }
      }
   }
   var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET A50_listungsaktion = CASE
WHEN A50_listungsaktion = 'Keine Listungsaktion'             THEN '0'
WHEN A50_listungsaktion = 'Keine Veränderung'                THEN '1'
WHEN A50_listungsaktion = 'nicht möglich'                    THEN '2'
WHEN A50_listungsaktion = 'SOLL-Listung = IST-Listung'       THEN '3'
WHEN A50_listungsaktion = 'Neulistung KL-Artikel'            THEN '4'
WHEN A50_listungsaktion = 'Einlistung Kauflandartikel'       THEN '5'
WHEN A50_listungsaktion = 'Einlistung Potenzialartikel'      THEN '6'
WHEN A50_listungsaktion = 'Auslistung'                       THEN '7'
WHEN A50_listungsaktion = 'Listung erweitern'                THEN '8'
WHEN A50_listungsaktion = 'Listung reduzieren'               THEN '9'
WHEN A50_listungsaktion = 'Listung erweitern und reduzieren' THEN '10'
WHEN A50_listungsaktion = 'Listung reduzieren und erweitern' THEN '11'
ELSE A50_listungsaktion
END
WHERE A500_kjwo_update = ? AND
      mandant_id = ?`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [IN_KJWO_UPDATE,IN_MANDANT_ID]
   }).execute();
   if (InFunc({
      sqlText : '',
      inArray : [`-9999`,`-9998`],
      inValue : VAR_GTIN
   })) {
      var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET A50_listungsaktion = '13'
WHERE A500_kjwo_update = ? AND
      mandant_id = ? AND
      matching_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [IN_KJWO_UPDATE,IN_MANDANT_ID,IN_MATCHING_ID]
      }).execute();
   }

   var sql_stmt = `UPDATE dbp_msi_data.tupel_mat SET A50_listungsaktion = '12'
WHERE A500_kjwo_update = ? AND
      ? NOT IN (SELECT
kjwo_update
FROM dbp_msi_data.nl_listung_kmo) AND
     mandant_id = ? AND
     matching_id = ?`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [IN_KJWO_UPDATE,IN_KJWO_UPDATE,IN_MANDANT_ID,IN_MATCHING_ID]
   }).execute();
}
 
$$;