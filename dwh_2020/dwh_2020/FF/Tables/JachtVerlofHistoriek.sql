CREATE TABLE [FF].[JachtVerlofHistoriek] (
    [JachtVerlofHistoriekID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [JachtVerlofNummer]      NVARCHAR (15)  NOT NULL,
    [Jaartal]                SMALLINT       NULL,
    [ProvincieID]            NVARCHAR (15)  NULL,
    [Naam]                   NVARCHAR (50)  NULL,
    [Voornaam]               NVARCHAR (50)  NULL,
    [GeboorteDatum]          DATETIME       NULL,
    [Nationaliteit]          NVARCHAR (50)  NULL,
    [Adres]                  NVARCHAR (50)  NULL,
    [PostCode]               NVARCHAR (15)  NULL,
    [GemeenteNaam]           NVARCHAR (100) NULL,
    [Land]                   NVARCHAR (50)  NULL,
    [Email]                  NVARCHAR (50)  NULL,
    [DossierNummerJager]     NVARCHAR (50)  NULL,
    [Weigering]              NVARCHAR (50)  NULL,
    [Commentaar]             NVARCHAR (800) NULL,
    [SoftDeleted]            BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION     NOT NULL,
    CONSTRAINT [PK_JachtVerlofHistoriek] PRIMARY KEY CLUSTERED ([JachtVerlofHistoriekID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_JachtVerlofHistoriek_JachtVerlofNummer]
    ON [FF].[JachtVerlofHistoriek]([JachtVerlofNummer] ASC)
    ON [Indexes];

