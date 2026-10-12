CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wup_stunden_tag_zentrale (MANDANT_ID FLOAT , WUP_ID FLOAT , NB_ID FLOAT , DAT DATE , UMS_NETTO_PLAN_MAN FLOAT , STUNDEN_MARKT FLOAT , STUNDEN_SONSTIGE FLOAT , STUNDEN_VERSETZUNG FLOAT , STUNDEN_PLAN FLOAT , STUNDEN_SONSTIGE_PLAN FLOAT , SPERRE_MONAT FLOAT , SPERRE_WOCHE FLOAT)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
 	var HANDLE_NOTFOUND;
	var fetch = (count,rows,stmt) => (count && rows.next() && Array.apply(null,Array(stmt.getColumnCount())).map((_,i) => rows.getColumnValue(i + 1))) || [];
	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = '00000', ERROR_HANDLERS, ACTIVITY_COUNT = 0, INTO;
	var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
	var fixBind = function (arg) {
	   arg = arg == undefined ? null : arg instanceof Date ? formatDate(arg) : arg;
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
	      HANDLE_NOTFOUND && HANDLE_NOTFOUND(_RS);
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
	
    
    EXEC(`MERGE INTO dbp_data.wup_stunden_tag_1 USING
	( -- using select
	SELECT
	v01.wup_id,
	v01.nb_id,
	v01.mandant_id,
	v01.dat,
	CASE
	WHEN ? IN (0,1) THEN COALESCE(?, v02.ums_netto_plan_man)
	ELSE v02.ums_netto_plan_man END AS ums_netto_plan_man,
	CASE
	WHEN ? <> 1 AND ? IN (0,1) THEN COALESCE(?, v02.stunden_markt)
	ELSE v02.stunden_markt END AS stunden_markt,
	CASE
	WHEN ? IN (0,1) THEN COALESCE(?, v02.stunden_sonstige)
	ELSE v02.stunden_sonstige END AS stunden_sonstige,
	CASE
	WHEN ? <> 1 AND ? IN (0,1) THEN COALESCE(?, v02.stunden_versetzung )
	ELSE v02.stunden_versetzung END AS stunden_versetzung,
	CASE
	WHEN ? IN (0,1) THEN COALESCE(?, v02.stunden_plan)
	ELSE v02.stunden_plan END AS stunden_plan,
	CASE
	WHEN ? IN (0,1) THEN COALESCE(?, v02.stunden_sonstige_plan)
	ELSE v02.stunden_sonstige_plan END AS stunden_sonstige_plan,
	v03.wrg_id
	FROM
	( -- v01
	SELECT
	v01_2.wup_id,
	v01_2.nb_id,
	v01_2.mandant_id,
	v01_1.dat
	FROM dbp_data.tag_1 v01_1
	-- cross join, damit ein vollstaendiger Kalender entsteht, in den die Werte eingepflegt werden koennen
	CROSS JOIN dbp_data.wup_1 v01_2
	WHERE mandant_id = ?
	AND wup_id       = ?
	AND nb_id        = ?
	AND dat          = ?
	) v01
	
	LEFT JOIN dbp_data.wup_stunden_tag_1 v02
	ON v01.wup_id      = v02.wup_id
	AND v01.nb_id      = v02.nb_id
	AND v01.mandant_id = v02.mandant_id
	AND v01.dat        = v02.dat
	
	LEFT JOIN
	(SELECT
	mandant_id,
	wrg_id
	FROM dbp_data.mandant_wrg_typ_zu_1
	WHERE wrg_typ_id = 1
	) v03
	ON v01.mandant_id = v03.mandant_id
	
	) using_select ON  dbp_data.wup_stunden_tag.wup_id     = using_select.wup_id
	AND dbp_data.wup_stunden_tag.nb_id      = using_select.nb_id
	AND dbp_data.wup_stunden_tag.mandant_id = using_select.mandant_id
	AND dbp_data.wup_stunden_tag.dat        = using_select.dat
	
	WHEN MATCHED THEN UPDATE
	SET
    wrg_id                = using_select.wrg_id
    ,ums_netto_plan_man    = using_select.ums_netto_plan_man
    ,stunden_markt         = using_select.stunden_markt
    ,stunden_sonstige      = using_select.stunden_sonstige
    ,stunden_versetzung    = using_select.stunden_versetzung
    ,stunden_plan          = using_select.stunden_plan
    ,stunden_sonstige_plan = using_select.stunden_sonstige_plan
	
	WHEN NOT MATCHED THEN INSERT
	(wup_id
	, nb_id
	, mandant_id
	, dat
	,wrg_id
	, ums_netto_plan_man
	,ums_netto_plan
	,stunden_markt
    ,stunden_sonstige
    ,stunden_versetzung
    ,stunden_plan
    ,stunden_sonstige_plan
	,stunden_plan_pep
	,stunden_co1_iks
	,stunden_co2_ea
	,stunden_co3_anue
	,stunden_co4_reinigung
	,stunden_co5_sonstige
	)
	VALUES
	(
	using_select.wup_id
	,using_select.nb_id
	,using_select.mandant_id
	,using_select.dat
	,using_select.wrg_id
	,using_select.ums_netto_plan_man
	,0
	,using_select.stunden_markt
	,using_select.stunden_sonstige
	,COALESCE(using_select.stunden_versetzung, 0)
	,using_select.stunden_plan
	,using_select.stunden_sonstige_plan
	,0
	,0
	,0
	,0
	,0
	,0
	)`,[SPERRE_WOCHE, UMS_NETTO_PLAN_MAN, 
      MANDANT_ID, SPERRE_MONAT, STUNDEN_MARKT, 
      SPERRE_MONAT, STUNDEN_SONSTIGE, 
      MANDANT_ID,  SPERRE_MONAT, STUNDEN_VERSETZUNG, 
      SPERRE_WOCHE, STUNDEN_PLAN,     
      SPERRE_WOCHE,STUNDEN_SONSTIGE_PLAN, 
      MANDANT_ID, WUP_ID, NB_ID, DAT]);
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;