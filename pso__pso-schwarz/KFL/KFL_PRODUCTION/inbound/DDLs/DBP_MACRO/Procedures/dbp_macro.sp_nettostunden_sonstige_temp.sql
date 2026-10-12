CREATE OR REPLACE PROCEDURE dbp_macro.sp_nettostunden_sonstige_temp (IN_MANDANT_ID FLOAT
, IN_NB_ID FLOAT
, IN_WUP_ID FLOAT
, IN_DAT STRING
, IN_STUNDEN_IST_KASSE FLOAT
, IN_STUNDEN_IST_FRISCHE FLOAT
, IN_STUNDEN_IST_WARE FLOAT
, IN_STUNDEN_IST_VERWALTUNG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	// Pflege sonstige Stunde (externe Stunden) per Transaction
// v1 einfaches UPSERT, heisst Timestamp aendert sich immer
// 2020.03.04 Nullchecking (Coalesce) added
// 2020-10-16 MSTR temp Bugfix
// 2020-10-21 wup_stunden_tag update (new columns)
var InFunc = function (objectParam) {
   var result = objectParam['inArray'];
   if (objectParam['sqlText'] != '') {
      var res = snowflake.createStatement({
         sqlText : objectParam['sqlText']
      }).execute();
      while ( res.next() ) {
         result.push(res.getColumnValue(1));
      }
   }
   return result.includes(objectParam['inValue']);
};
{
   var var_mandant_id;
   var var_wup_id;
   var var_nb_id;
   var var_dat;
   var var_hr_objekt_bereich_id;
   var var_stunden;
   var var_quelle_id;
   var var_stunden_typ_fg;
   var var_wrg_id;
   var var_dat_zeit_aenderung;
   var_mandant_id = IN_MANDANT_ID;
   var_wup_id = IN_WUP_ID;
   var_nb_id = IN_NB_ID;
   var_dat = IN_DAT;
   var_quelle_id = 9;
   var_stunden_typ_fg = 0;
   var_wrg_id = function () {
         if (IN_MANDANT_ID == 2) {
            return `CZK`;
         } else if (IN_MANDANT_ID == 3) {
            return `PLN`;
         } else if (IN_MANDANT_ID == 4) {
            return `MDL`;
         } else if (IN_MANDANT_ID == 6) {
            return `HRK`;
         } else if (IN_MANDANT_ID == 7) {
            return `RON`;
         } else if (IN_MANDANT_ID == 8) {
            return `BGN`;
         } else {
            return `EUR`;
         }
      }();
   myTS = new Date();
   const offset = myTS.getTimezoneOffset()
   var_dat_zeit_aenderung = myTS.toISOString().split('T')[0] + ' ' + myTS.toISOString().split('T')[1].substring(0,8);
   // UPSERT Bereich Kasse
   var_hr_objekt_bereich_id = 10;
   var_stunden = function () {
         if (InFunc({
            sqlText : '',
            inArray : [2,5,8],
            inValue : var_mandant_id
         })) {
            return function () {
               var sql_stmt = `SELECT
Abs(Coalesce(?, 0))`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_KASSE].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         } else {
            return function () {
               var sql_stmt = `SELECT
Coalesce(?, 0)`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_KASSE].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         }
      }();
   //SET var_stunden = Coalesce(stunden_ist_kasse, 0);
   var sql_stmt = `MERGE INTO dbp_data.nettostunden_bereich as A
                   USING      (SELECT ? AS WUP_ID, ? AS NB_ID, ? AS MANDANT_ID, ? AS DAT, ? AS quelle_id, ? AS hr_objekt_bereich_id) B 
                      ON A.wup_id = B.WUP_ID
                      AND A.nb_id = B.NB_ID
                      AND A.mandant_id = B.MANDANT_ID
                      AND A.dat = B.DAT::date 
                      AND A.quelle_id = B.quelle_id
                      AND A.hr_objekt_bereich_id = B.hr_objekt_bereich_id 
                   WHEN MATCHED THEN UPDATE SET A.dat_zeit_aenderung = ?::timestamp_ntz, A.stunden = ?
                   WHEN NOT MATCHED THEN 
                   INSERT (MANDANT_ID, WUP_ID, NB_ID, DAT, HR_OBJEKT_BEREICH_ID, STUNDEN, QUELLE_ID, STUNDEN_TYP_FG, DAT_ZEIT_AENDERUNG)
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?::timestamp_ntz)`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [var_wup_id,var_nb_id,var_mandant_id,var_dat,var_quelle_id,var_hr_objekt_bereich_id,
              var_dat_zeit_aenderung,var_stunden,
              var_mandant_id,var_wup_id,var_nb_id,var_dat,var_hr_objekt_bereich_id,var_stunden,var_quelle_id,var_stunden_typ_fg,var_dat_zeit_aenderung].map(function(x){return x === undefined ? null : x})
   }).execute();

   
   
   // UPSERT Bereich Frische
   var_hr_objekt_bereich_id = 30;
   var_stunden = function () {
         if (InFunc({
            sqlText : '',
            inArray : [2,5,8],
            inValue : var_mandant_id
         })) {
            return function () {
               var sql_stmt = `SELECT
Abs(Coalesce(?, 0))`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_FRISCHE].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         } else {
            return function () {
               var sql_stmt = `SELECT
Coalesce(?, 0)`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_FRISCHE].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         }
      }();
   //SET var_stunden = Coalesce(stunden_ist_frische, 0);
   var sql_stmt = `MERGE INTO dbp_data.nettostunden_bereich as A
                   USING      (SELECT ? AS WUP_ID, ? AS NB_ID, ? AS MANDANT_ID, ? AS DAT, ? AS quelle_id, ? AS hr_objekt_bereich_id) B 
                      ON A.wup_id = B.WUP_ID
                      AND A.nb_id = B.NB_ID
                      AND A.mandant_id = B.MANDANT_ID
                      AND A.dat = B.DAT::date
                      AND A.quelle_id = B.quelle_id
                      AND A.hr_objekt_bereich_id = B.hr_objekt_bereich_id 
                   WHEN MATCHED THEN UPDATE SET A.dat_zeit_aenderung = ?::timestamp_ntz, A.stunden = ?
                   WHEN NOT MATCHED THEN INSERT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?::timestamp_ntz)`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [var_wup_id,var_nb_id,var_mandant_id,var_dat,var_quelle_id,var_hr_objekt_bereich_id,
               var_dat_zeit_aenderung,var_stunden,
               var_mandant_id,var_wup_id,var_nb_id,var_dat,var_hr_objekt_bereich_id,var_stunden,var_quelle_id,var_stunden_typ_fg,var_dat_zeit_aenderung].map(function(x){return x === undefined ? null : x})
   }).execute
   

   // UPSERT Bereich Ware
   var_hr_objekt_bereich_id = 40;
   var_stunden = function () {
         if (InFunc({
            sqlText : '',
            inArray : [2,5,8],
            inValue : var_mandant_id
         })) {
            return function () {
               var sql_stmt = `SELECT
Abs(Coalesce(?, 0))`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_WARE].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         } else {
            return function () {
               var sql_stmt = `SELECT
Coalesce(?, 0)`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_WARE].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         }
      }();
   //SET var_stunden = Coalesce(stunden_ist_ware, 0);
   var sql_stmt = `MERGE INTO dbp_data.nettostunden_bereich as A
                   USING      (SELECT ? AS WUP_ID, ? AS NB_ID, ? AS MANDANT_ID, ? AS DAT, ? AS quelle_id, ? AS hr_objekt_bereich_id) B 
                      ON A.wup_id = B.WUP_ID
                      AND A.nb_id = B.NB_ID
                      AND A.mandant_id = B.MANDANT_ID
                      AND A.dat = B.DAT::date 
                      AND A.quelle_id = B.quelle_id
                      AND A.hr_objekt_bereich_id = B.hr_objekt_bereich_id 
                   WHEN MATCHED THEN UPDATE SET A.dat_zeit_aenderung = ?::timestamp_ntz, A.stunden = ?
                   WHEN NOT MATCHED THEN INSERT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?::timestamp_ntz)`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [var_wup_id,var_nb_id,var_mandant_id,var_dat,var_quelle_id,var_hr_objekt_bereich_id,
               var_dat_zeit_aenderung,var_stunden,
               var_mandant_id,var_wup_id,var_nb_id,var_dat,var_hr_objekt_bereich_id,var_stunden,var_quelle_id,var_stunden_typ_fg,var_dat_zeit_aenderung].map(function(x){return x === undefined ? null : x})
   }).execute();
   
    
   // UPSERT Bereich Verwaltung
   var_hr_objekt_bereich_id = 60;
   var_stunden = function () {
         if (InFunc({
            sqlText : '',
            inArray : [2,5,8],
            inValue : var_mandant_id
         })) {
            return function () {
               var sql_stmt = `SELECT
Abs(Coalesce(?, 0))`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_VERWALTUNG].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         } else {
            return function () {
               var sql_stmt = `SELECT
Coalesce(?, 0)`;
               var stmt = snowflake.createStatement({
                  sqlText : sql_stmt,
                  binds : [IN_STUNDEN_IST_VERWALTUNG].map(function(x){return x === undefined ? null : x})
               });
               var res = stmt.execute();
               res.next();
               return res.getColumnValue(1);
            }();
         }
      }();
   //SET var_stunden = Coalesce(stunden_ist_verwaltung, 0);
   var sql_stmt = `MERGE INTO dbp_data.nettostunden_bereich as A
                   USING      (SELECT ? AS WUP_ID, ? AS NB_ID, ? AS MANDANT_ID, ? AS DAT, ? AS quelle_id, ? AS hr_objekt_bereich_id) B 
                      ON A.wup_id = B.WUP_ID
                      AND A.nb_id = B.NB_ID
                      AND A.mandant_id = B.MANDANT_ID
                      AND A.dat = B.DAT::date 
                      AND A.quelle_id = B.quelle_id
                      AND A.hr_objekt_bereich_id = B.hr_objekt_bereich_id 
                   WHEN MATCHED THEN UPDATE SET A.dat_zeit_aenderung = ?::timestamp_ntz, A.stunden = ?
                   WHEN NOT MATCHED THEN INSERT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?::timestamp_ntz)`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [var_wup_id,var_nb_id,var_mandant_id,var_dat,var_quelle_id,var_hr_objekt_bereich_id,
               var_dat_zeit_aenderung,var_stunden,
               var_mandant_id,var_wup_id,var_nb_id,var_dat,var_hr_objekt_bereich_id,var_stunden,var_quelle_id,var_stunden_typ_fg,var_dat_zeit_aenderung].map(function(x){return x === undefined ? null : x})
   }).execute();
   // UPSERT Filiale (wup_stunden_tag)
   var_hr_objekt_bereich_id = -1;
   var_stunden = function () {
         if (InFunc({
            sqlText : '',
            inArray : [2,5,8],
            inValue : var_mandant_id
         })) {
            return function () {
                        var sql_stmt = `SELECT
Coalesce(Abs(?), 0)`;
                        var stmt = snowflake.createStatement({
                           sqlText : sql_stmt,
                           binds : [IN_STUNDEN_IST_KASSE].map(function(x){return x === undefined ? null : x})
                        });
                        var res = stmt.execute();
                        res.next();
                        return res.getColumnValue(1);
                     }() + function () {
                        var sql_stmt = `SELECT
Coalesce(Abs(in_tunden_ist_frische), 0)`;
                        var stmt = snowflake.createStatement({
                           sqlText : sql_stmt,
                           binds : [].map(function(x){return x === undefined ? null : x})
                        });
                        var res = stmt.execute();
                        res.next();
                        return res.getColumnValue(1);
                     }() + function () {
                     var sql_stmt = `SELECT
Coalesce(Abs(?), 0)`;
                     var stmt = snowflake.createStatement({
                        sqlText : sql_stmt,
                        binds : [IN_STUNDEN_IST_WARE].map(function(x){return x === undefined ? null : x})
                     });
                     var res = stmt.execute();
                     res.next();
                     return res.getColumnValue(1);
                  }() + function () {
                  var sql_stmt = `SELECT
Coalesce(Abs(?), 0)`;
                  var stmt = snowflake.createStatement({
                     sqlText : sql_stmt,
                     binds : [IN_STUNDEN_IST_VERWALTUNG].map(function(x){return x === undefined ? null : x})
                  });
                  var res = stmt.execute();
                  res.next();
                  return res.getColumnValue(1);
               }();
         } else {
            return function () {
                        var sql_stmt = `SELECT
Coalesce(?, 0)`;
                        var stmt = snowflake.createStatement({
                           sqlText : sql_stmt,
                           binds : [IN_STUNDEN_IST_KASSE].map(function(x){return x === undefined ? null : x})
                        });
                        var res = stmt.execute();
                        res.next();
                        return res.getColumnValue(1);
                     }() + function () {
                        var sql_stmt = `SELECT
Coalesce(?, 0)`;
                        var stmt = snowflake.createStatement({
                           sqlText : sql_stmt,
                           binds : [IN_STUNDEN_IST_FRISCHE].map(function(x){return x === undefined ? null : x})
                        });
                        var res = stmt.execute();
                        res.next();
                        return res.getColumnValue(1);
                     }() + function () {
                     var sql_stmt = `SELECT
Coalesce(?, 0)`;
                     var stmt = snowflake.createStatement({
                        sqlText : sql_stmt,
                        binds : [IN_STUNDEN_IST_WARE].map(function(x){return x === undefined ? null : x})
                     });
                     var res = stmt.execute();
                     res.next();
                     return res.getColumnValue(1);
                  }() + function () {
                  var sql_stmt = `SELECT
Coalesce(?, 0)`;
                  var stmt = snowflake.createStatement({
                     sqlText : sql_stmt,
                     binds : [IN_STUNDEN_IST_VERWALTUNG].map(function(x){return x === undefined ? null : x})
                  });
                  var res = stmt.execute();
                  res.next();
                  return res.getColumnValue(1);
               }();
         }
      }();
   //SET var_stunden = Coalesce(stunden_ist_kasse, 0) + Coalesce(stunden_ist_frische, 0) + Coalesce(stunden_ist_ware, 0) + Coalesce(stunden_ist_verwaltung, 0);
   var sql_stmt = `MERGE INTO dbp_data.wup_stunden_tag AS A
                   USING (SELECT ? AS wup_id, ? AS nb_id, ? AS mandant_id, ? AS dat) AS B
                     ON A.wup_id = B.wup_id
                     AND A.nb_id = B.nb_id
                     AND A.mandant_id = B.mandant_id
                     AND A.dat = B.dat::date 
                   WHEN MATCHED THEN UPDATE SET A.stunden_sonstige = ? 
                   WHEN NOT MATCHED THEN INSERT VALUES (?, ?, ?, ?::date, 0 , ?, NULL ,0 ,0, NULL, ?, NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)`;
   snowflake.createStatement({
      sqlText : sql_stmt,
      binds : [var_wup_id,var_nb_id,var_mandant_id,var_dat,
               var_stunden,
               var_wup_id, var_nb_id,var_mandant_id,var_dat,var_stunden,var_wrg_id].map(function(x){return x === undefined ? null : x})
   }).execute();
}

var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
 
$$;