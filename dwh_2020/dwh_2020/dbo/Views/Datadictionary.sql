--drop view datadictionary
create  view Datadictionary as
SELECT

     SysTbls.name AS [TabelNaam]

    ,SysCols.name AS [KolomNaam]

    ,ExtProp.value AS Beschrijving

    ,Systyp.name AS [DataType]

    ,CASE WHEN Systyp.name IN('nvarchar','nchar')

               THEN (SysCols.max_length / 2)

          WHEN Systyp.name IN('char')

               THEN SysCols.max_length

          ELSE NULL

          END AS 'Length of Column'

    ,CASE WHEN SysCols.is_nullable = 0

               THEN 'No'

          WHEN SysCols.is_nullable = 1

               THEN 'Yes'

          ELSE NULL

          END AS 'Column is Nullable'   

    ,SysObj.create_date AS [TabelCreatieDatum]

    ,SysObj.modify_date AS [TabelWijzigingDatum]

FROM sys.tables AS SysTbls

   LEFT JOIN sys.extended_properties AS ExtProp

         ON ExtProp.major_id = SysTbls.[object_id]

   LEFT JOIN sys.columns AS SysCols

         ON ExtProp.major_id = SysCols.[object_id]

         AND ExtProp.minor_id = SysCols.column_id

   LEFT JOIN sys.objects as SysObj

         ON SysTbls.[object_id] = SysObj.[object_id]

   LEFT JOIN sys.types AS SysTyp

         ON SysCols.user_type_id = SysTyp.user_type_id

/*WHERE class = 1 --Object or column

 AND SysTbls.name IS NOT NULL

  AND SysCols.name IS NOT NULL */

 -- order by  SysTbls.name, SysCols.name