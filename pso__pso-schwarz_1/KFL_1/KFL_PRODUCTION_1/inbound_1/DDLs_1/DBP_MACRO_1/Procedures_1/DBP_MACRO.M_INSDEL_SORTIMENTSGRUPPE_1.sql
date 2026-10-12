CREATE OR REPLACE PROCEDURE dbp_macro.m_insdel_sortimentsgruppe (MANDANT_ID FLOAT, WG_ID FLOAT, SORTIMENTSGRUPPE_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
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
if (!InFunc({
   sqlText : `(SELECT
mandant_id
FROM dbp_view.v_mandant_1)`,
   inArray : [],
   inValue : MANDANT_ID
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Mandant_1 existiert nicht`;
}

var sql_stmt = `SELECT wg_id
                FROM dbp_view.v_wg_per_1 
                WHERE arthiertyp_id = 2 
                  AND mandant_id = ?
                  AND wg_id = ?`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[MANDANT_ID, WG_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() == 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `Warengruppe existiert nicht`;
	}

var sql_stmt = `(SELECT
wg_hierarchie_id
FROM dbp_view.v_wg_hierarchie_spr_zu_1
WHERE mandant_id = ?
AND arthiertyp_id = 3
AND wg_hierarchie_ebene_id = 1
GROUP BY wg_hierarchie_id
)`;
var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID]
});
var res = stmt.execute();
res.next();
var subQueryVariable0 = res.getColumnValue(1);
if (!InFunc({
   sqlText : '',
   inArray : subQueryVariable0 && SORTIMENTSGRUPPE_ID != null,
   inValue : SORTIMENTSGRUPPE_ID
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Sortimentsgruppe Text existiert nicht`;
}
var sql_stmt = `(SELECT
wg_hierarchie_id
FROM dbp_view.v_wg_hierarchie_zu_per_1
WHERE mandant_id = ?
AND arthiertyp_id = 3
AND wg_hierarchie_ebene_id = 1
AND dat_bis = 80991231
GROUP BY wg_hierarchie_id
)`;
var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID]
});
var res = stmt.execute();
res.next();
var subQueryVariable1 = res.getColumnValue(1);
if (!InFunc({
   sqlText : '',
   inArray : subQueryVariable1 && SORTIMENTSGRUPPE_ID != null,
   inValue : SORTIMENTSGRUPPE_ID
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Sortimentsgruppe existiert nicht`;
}
var resultSetCounter = 0;
var tablelist = new Array;
var procname = `dbp_macro.m_insdel_sortimentsgruppe_`;
var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
var stmt = snowflake.createStatement({
   sqlText : sql_command
});
var res = stmt.execute();
res.next();
var sessionid = procname + res.getColumnValue(1);
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
var setname = `SELECT
'alt' AS Status_1,
t01.mandant_id,
t01.wg_hierarchie_id AS wg_id,
t02.wg_hierarchie_bez AS sortiments_bez
FROM dbp_view.v_wg_hierarchie_zu_per_1 AS t01
LEFT JOIN dbp_view.v_wg_hierarchie_spr_zu_1 AS t02
ON t01.mandant_id = t02.mandant_id
AND t01.wg_hierarchie_mutter_id = t02.wg_hierarchie_id
AND t02.arthiertyp_id = t02.arthiertyp_id
AND t02.wg_hierarchie_ebene_id = 1
WHERE t01.wg_hierarchie_ebene_id = 0
AND t01.arthiertyp_id = 3
AND t02.spr_id = 22
AND t01.mandant_id = ?
AND t01.wg_hierarchie_id = ?
AND t01.dat_bis = 9999-12-31`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WG_ID]
}).execute();
// Loeschen von Zuordnung
var sql_stmt = `DELETE FROM dbp_view.v_wg_hierarchie_zu_per_1
WHERE mandant_id = ?
AND wg_hierarchie_id = ?
AND arthiertyp_id = 3
AND wg_hierarchie_ebene_id = 0`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WG_ID]
}).execute();
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
// Neuen Satz hinzufuegen
var sql_stmt = `INSERT INTO dbp_view.v_wg_hierarchie_zu_per_1 (mandant_id,arthiertyp_id,wg_hierarchie_ebene_id,wg_hierarchie_id,wg_hierarchie_mutter_id,dat_von,dat_bis)SELECT
t01.mandant_id,
t01.arthiertyp_id,
0 AS wg_hierarchie_ebene_id,
?,
t01.wg_hierarchie_id,
101 AS dat_von,
80991231 AS dat_bis
FROM dbp_view.v_wg_hierarchie_zu_per_1 AS t01
LEFT JOIN dbp_view.v_wg_hierarchie_zu_per_1 AS t02
ON t01.mandant_id = t02.mandant_id
AND t01.arthiertyp_id = t02.arthiertyp_id
AND t02.wg_hierarchie_ebene_id = 0
AND t02.wg_hierarchie_id = ?
AND t02.dat_von = 80991231
WHERE t01.mandant_id = ?
AND t01.arthiertyp_id = 3
AND t01.wg_hierarchie_ebene_id = 1
AND t01.wg_hierarchie_id = ?
AND t02.mandant_id IS NULL
AND ? IS NOT NULL`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [WG_ID,WG_ID,MANDANT_ID,SORTIMENTSGRUPPE_ID,SORTIMENTSGRUPPE_ID]
}).execute();
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
var setname = `SELECT
'neu' AS Status_1,
t01.mandant_id,
t01.wg_hierarchie_id AS wg_id,
t02.wg_hierarchie_bez AS sortiments_bez
FROM dbp_view.v_wg_hierarchie_zu_per_1 AS t01
LEFT JOIN dbp_view.v_wg_hierarchie_spr_zu_1 AS t02
ON t01.mandant_id = t02.mandant_id
AND t01.wg_hierarchie_mutter_id = t02.wg_hierarchie_id
AND t02.arthiertyp_id = t02.arthiertyp_id
AND t02.wg_hierarchie_ebene_id = 1
WHERE t01.wg_hierarchie_ebene_id = 0
AND t01.arthiertyp_id = 3
AND t02.spr_id = 22
AND t01.mandant_id = ?
AND t01.wg_hierarchie_id = ?
AND t01.dat_bis = 9999-12-31`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WG_ID]
}).execute();
return tablelist;
 
$$;

