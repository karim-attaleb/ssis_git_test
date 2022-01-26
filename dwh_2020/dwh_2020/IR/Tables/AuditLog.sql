CREATE TABLE [IR].[AuditLog] (
    [AuditLogID]  INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Date]        DATETIME        NOT NULL,
    [TableName]   NVARCHAR (128)  NOT NULL,
    [ColumnName]  NVARCHAR (128)  NOT NULL,
    [RowID]       NVARCHAR (50)   NOT NULL,
    [ValueBefore] NVARCHAR (1000) NULL,
    [ValueAfter]  NVARCHAR (1000) NULL,
    [UserName]    NVARCHAR (50)   NULL,
    [BronID]      NVARCHAR (15)   NOT NULL,
    CONSTRAINT [PK_AuditLog_AuditLogID] PRIMARY KEY CLUSTERED ([AuditLogID] ASC) ON [DataLog]
) ON [DataLog];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Doc', @value = N'Waarom is deze tabel leeg ? Reflectie : auditlog op db niveau uitbouwen ipv dit applicatief uit te stellen ? ', @level0type = N'SCHEMA', @level0name = N'IR', @level1type = N'TABLE', @level1name = N'AuditLog';

