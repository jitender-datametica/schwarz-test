CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_NETTOSTUNDEN_SONSTIGE("MANDANT_ID" FLOAT, "NB_ID" FLOAT, "WUP_ID" FLOAT, "DAT" DATE, "STUNDEN_IST_KASSE" FLOAT, "STUNDEN_IST_FRISCHE" FLOAT, "STUNDEN_IST_WARE" FLOAT, "STUNDEN_IST_VERWALTUNG" FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	// Pflege sonstige Stunde (externe Stunden) per Transaction
	// v1 einfaches UPSERT, heisst Timestamp aendert sich immer
	// 2020.03.04 Nullchecking (Coalesce) added
	// 2020-10-16 (temp MSTR PATCH)							   
	// 2020-12-01 ssch0611 : wup_stunden_tag update (new columns added)
	// REGION SnowConvert Helpers Code
	var HANDLE_NOTFOUND;
	var fetch = (count,rows,stmt) => (count && rows.next() && Array.apply(null,Array(stmt.getColumnCount())).map((_,i) => rows.getColumnValue(i + 1))) || [];
	var _RS, ROW_COUNT, _ROWS, MESSAGE_TEXT, SQLCODE = 0, SQLSTATE = ''00000'', ERROR_HANDLERS, ACTIVITY_COUNT = 0, INTO;
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
	// END REGION
	
	var VAR_MANDANT_ID;
	var VAR_WUP_ID;
	var VAR_NB_ID;
	var VAR_DAT;
	var VAR_HR_OBJEKT_BEREICH_ID;
	var VAR_STUNDEN;
	var VAR_QUELLE_ID;
	var VAR_STUNDEN_TYP_FG;
	var VAR_WRG_ID;
	var VAR_DAT_ZEIT_AENDERUNG;
	VAR_MANDANT_ID = MANDANT_ID;
	VAR_WUP_ID = WUP_ID;
	VAR_NB_ID = NB_ID;
	VAR_DAT = DAT;
	VAR_QUELLE_ID = 9;
	VAR_STUNDEN_TYP_FG = 0;
	
    VAR_WRG_ID = VAR_MANDANT_ID == 2 && `CZK` || (VAR_MANDANT_ID == 3 && `PLN` || (VAR_MANDANT_ID == 4 && `MDL` || (VAR_MANDANT_ID == 6 && `HRK` || (VAR_MANDANT_ID == 7 && `RON` || (VAR_MANDANT_ID == 8 && `BGN` || `EUR`)))));
	
    VAR_DAT_ZEIT_AENDERUNG = (EXEC(`SELECT
	to_timestamp_ntz(CURRENT_TIMESTAMP())`,[]).INTO())[0];  
    
    
	// UPSERT Bereich Kasse
	VAR_HR_OBJEKT_BEREICH_ID = 10;
    VAR_STUNDEN = (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_KASSE]).INTO())[0];

	EXEC(`BEGIN`)	
    
    EXEC(`MERGE INTO dbp_data.nettostunden_bereich as tgt 
    USING (
        SELECT ? AS wup_id
            ,? AS nb_id
            ,? AS mandant_id
            ,? AS dat
	        ,? AS quelle_id 
            ,? AS hr_objekt_bereich_id
    ) as source
    ON  tgt.wup_id                = source.wup_id
    AND tgt.nb_id                 = source.nb_id
    AND tgt.mandant_id            = source.mandant_id
    AND tgt.dat                   = source.dat
	AND tgt.quelle_id             = source.quelle_id
    AND tgt.hr_objekt_bereich_id  = source.hr_objekt_bereich_id
	WHEN MATCHED THEN 
        UPDATE SET dat_zeit_aenderung = to_timestamp(?)
                 , stunden = ?
	WHEN NOT MATCHED THEN 
		INSERT (MANDANT_ID 
                ,WUP_ID 
                ,NB_ID 
                ,DAT 
                ,HR_OBJEKT_BEREICH_ID 
                ,STUNDEN 
                ,QUELLE_ID 
                ,STUNDEN_TYP_FG 
                ,DAT_ZEIT_AENDERUNG)
		VALUES  (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    
    [VAR_WUP_ID
    , VAR_NB_ID
    , VAR_MANDANT_ID
    , VAR_DAT
    , VAR_QUELLE_ID
    , VAR_HR_OBJEKT_BEREICH_ID

    , VAR_DAT_ZEIT_AENDERUNG,VAR_STUNDEN

    , VAR_MANDANT_ID , VAR_WUP_ID , VAR_NB_ID , VAR_DAT , VAR_HR_OBJEKT_BEREICH_ID , VAR_STUNDEN , VAR_QUELLE_ID , VAR_STUNDEN_TYP_FG , VAR_DAT_ZEIT_AENDERUNG]);
	
    // UPSERT Bereich Frische
	VAR_HR_OBJEKT_BEREICH_ID = 30;
	VAR_STUNDEN = (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_FRISCHE]).INTO())[0];

    EXEC(`MERGE INTO dbp_data.nettostunden_bereich as tgt 
    USING (
        SELECT ? AS wup_id
            ,? AS nb_id
            ,? AS mandant_id
            ,? AS dat
	        ,? AS quelle_id 
            ,? AS hr_objekt_bereich_id
    ) as source
    ON  tgt.wup_id                = source.wup_id
    AND tgt.nb_id                 = source.nb_id
    AND tgt.mandant_id            = source.mandant_id
    AND tgt.dat                   = source.dat
	AND tgt.quelle_id             = source.quelle_id
    AND tgt.hr_objekt_bereich_id  = source.hr_objekt_bereich_id
	WHEN MATCHED THEN 
        UPDATE SET dat_zeit_aenderung = to_timestamp(?)
                 , stunden = ?
	WHEN NOT MATCHED THEN 
		INSERT (MANDANT_ID 
                ,WUP_ID 
                ,NB_ID 
                ,DAT 
                ,HR_OBJEKT_BEREICH_ID 
                ,STUNDEN 
                ,QUELLE_ID 
                ,STUNDEN_TYP_FG 
                ,DAT_ZEIT_AENDERUNG)
		VALUES  (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    
    [VAR_WUP_ID
    , VAR_NB_ID
    , VAR_MANDANT_ID
    , VAR_DAT
    , VAR_QUELLE_ID
    , VAR_HR_OBJEKT_BEREICH_ID

    , VAR_DAT_ZEIT_AENDERUNG,VAR_STUNDEN

    , VAR_MANDANT_ID , VAR_WUP_ID , VAR_NB_ID , VAR_DAT , VAR_HR_OBJEKT_BEREICH_ID , VAR_STUNDEN , VAR_QUELLE_ID , VAR_STUNDEN_TYP_FG , VAR_DAT_ZEIT_AENDERUNG]);

	  
	
    
    // UPSERT Bereich Ware
	VAR_HR_OBJEKT_BEREICH_ID = 40;
	VAR_STUNDEN = (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_WARE]).INTO())[0];
	
    
    EXEC(`MERGE INTO dbp_data.nettostunden_bereich as tgt 
    USING (
        SELECT ? AS wup_id
            ,? AS nb_id
            ,? AS mandant_id
            ,? AS dat
	        ,? AS quelle_id 
            ,? AS hr_objekt_bereich_id
    ) as source
    ON  tgt.wup_id                = source.wup_id
    AND tgt.nb_id                 = source.nb_id
    AND tgt.mandant_id            = source.mandant_id
    AND tgt.dat                   = source.dat
	AND tgt.quelle_id             = source.quelle_id
    AND tgt.hr_objekt_bereich_id  = source.hr_objekt_bereich_id
	WHEN MATCHED THEN 
        UPDATE SET dat_zeit_aenderung = to_timestamp(?)
                 , stunden = ?
	WHEN NOT MATCHED THEN 
		INSERT (MANDANT_ID 
                ,WUP_ID 
                ,NB_ID 
                ,DAT 
                ,HR_OBJEKT_BEREICH_ID 
                ,STUNDEN 
                ,QUELLE_ID 
                ,STUNDEN_TYP_FG 
                ,DAT_ZEIT_AENDERUNG)
		VALUES  (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    
    [VAR_WUP_ID
    , VAR_NB_ID
    , VAR_MANDANT_ID
    , VAR_DAT
    , VAR_QUELLE_ID
    , VAR_HR_OBJEKT_BEREICH_ID

    , VAR_DAT_ZEIT_AENDERUNG,VAR_STUNDEN

    , VAR_MANDANT_ID , VAR_WUP_ID , VAR_NB_ID , VAR_DAT , VAR_HR_OBJEKT_BEREICH_ID , VAR_STUNDEN , VAR_QUELLE_ID , VAR_STUNDEN_TYP_FG , VAR_DAT_ZEIT_AENDERUNG]);

    
        
    // UPSERT Bereich Verwaltung
	VAR_HR_OBJEKT_BEREICH_ID = 60;
	VAR_STUNDEN = (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_VERWALTUNG]).INTO())[0];
	
    
    EXEC(`MERGE INTO dbp_data.nettostunden_bereich as tgt 
    USING (
        SELECT ? AS wup_id
            ,? AS nb_id
            ,? AS mandant_id
            ,? AS dat
	        ,? AS quelle_id 
            ,? AS hr_objekt_bereich_id
    ) as source
    ON  tgt.wup_id                = source.wup_id
    AND tgt.nb_id                 = source.nb_id
    AND tgt.mandant_id            = source.mandant_id
    AND tgt.dat                   = source.dat
	AND tgt.quelle_id             = source.quelle_id
    AND tgt.hr_objekt_bereich_id  = source.hr_objekt_bereich_id
	WHEN MATCHED THEN 
        UPDATE SET dat_zeit_aenderung = to_timestamp(?)
                 , stunden = ?
	WHEN NOT MATCHED THEN 
		INSERT (MANDANT_ID 
                ,WUP_ID 
                ,NB_ID 
                ,DAT 
                ,HR_OBJEKT_BEREICH_ID 
                ,STUNDEN 
                ,QUELLE_ID 
                ,STUNDEN_TYP_FG 
                ,DAT_ZEIT_AENDERUNG)
		VALUES  (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
    
    [VAR_WUP_ID
    , VAR_NB_ID
    , VAR_MANDANT_ID
    , VAR_DAT
    , VAR_QUELLE_ID
    , VAR_HR_OBJEKT_BEREICH_ID

    , VAR_DAT_ZEIT_AENDERUNG,VAR_STUNDEN

    , VAR_MANDANT_ID , VAR_WUP_ID , VAR_NB_ID , VAR_DAT , VAR_HR_OBJEKT_BEREICH_ID , VAR_STUNDEN , VAR_QUELLE_ID , VAR_STUNDEN_TYP_FG , VAR_DAT_ZEIT_AENDERUNG]);

    
    
    
    // UPSERT Filiale (wup_stunden_tag)
	VAR_HR_OBJEKT_BEREICH_ID = -1;
	VAR_STUNDEN = (
           EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_KASSE]).INTO())[0] 
        + (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_FRISCHE]).INTO())[0] 
        + (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_WARE]).INTO())[0] 
        + (EXEC(`SELECT	Coalesce(?, 0)`,[STUNDEN_IST_VERWALTUNG]).INTO())[0];

   if (VAR_MANDANT_ID == 1) {mandant_krz = ''DE''}
   else if (VAR_MANDANT_ID == 2) {mandant_krz = ''CZ''}        
   else if (VAR_MANDANT_ID == 3) {mandant_krz = ''PL''}        
   else if (VAR_MANDANT_ID == 4) {mandant_krz = ''MD''}        
   else if (VAR_MANDANT_ID == 5) {mandant_krz = ''SK''}        
   else if (VAR_MANDANT_ID == 6) {mandant_krz = ''HR''}        
   else if (VAR_MANDANT_ID == 7) {mandant_krz = ''RO''}        
   else if (VAR_MANDANT_ID == 8) {mandant_krz = ''BG''}	

   EXEC(`MERGE INTO dbp_data.wup_stunden_tag_` + mandant_krz + `  as tgt 
    USING (
        SELECT ? AS wup_id
            ,? AS nb_id
            ,? AS mandant_id
            ,? AS dat
    ) as source
    ON  tgt.wup_id                = source.wup_id
    AND tgt.nb_id                 = source.nb_id
    AND tgt.mandant_id            = source.mandant_id
    AND tgt.dat                   = source.dat
	WHEN MATCHED THEN 
        UPDATE SET stunden_sonstige = ?
	WHEN NOT MATCHED THEN 
		INSERT (WUP_ID,NB_ID,MANDANT_ID,DAT,STUNDEN_MARKT,STUNDEN_SONSTIGE,STUNDEN_PLAN,STUNDEN_CO5_SONSTIGE,UMS_NETTO_PLAN,UMS_NETTO_PLAN_MAN,WRG_ID,STUNDEN_SONSTIGE_PLAN,STUNDEN_CO1_IKS,STUNDEN_CO2_EA,STUNDEN_CO3_ANUE,STUNDEN_CO4_REINIGUNG,STUNDEN_VERSETZUNG,STUNDEN_PLAN_PEP,STUNDEN_PLAN_MELDESCHLUSS_PLUS1,UMS_NETTO_PLAN_MAN_MELDESCHLUSS_PLUS2,STUNDEN_CO_IST,STUNDEN_CO_PLAN,STUNDEN_PLAN_MELDESCHLUSS_PLUS2,UMS_NETTO_PLAN_MAN_MELDESCHLUSS_PLUS1,STUNDEN_CO_PLAN_PLUS1,STUNDEN_CO_PLAN_PLUS2,STUNDEN_SONSTIGE_PLAN_PLUS1,STUNDEN_SONSTIGE_PLAN_PLUS2)
		VALUES  (?, ?, ?, ?, 0, ?, NULL,0, 0, NULL, ?, NULL, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)`,
    
    [VAR_WUP_ID
    , VAR_NB_ID
    , VAR_MANDANT_ID
    , VAR_DAT

    , VAR_STUNDEN

    , VAR_WUP_ID, VAR_NB_ID, VAR_MANDANT_ID , VAR_DAT , VAR_STUNDEN, VAR_WRG_ID ]);

EXEC(`COMMIT`)

';