CREATE TABLE [IR].[IndieningPartij] (
    [IndieningPartijID]       INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningPartijParentID] INT              NULL,
    [IndieningID]             INT              NOT NULL,
    [IndieningPartijTypeID]   NVARCHAR (15)    NOT NULL,
    [PartijTypeID]            NVARCHAR (15)    NOT NULL,
    [DoelgroepID]             NVARCHAR (15)    NULL,
    [Naam]                    NVARCHAR (250)   NOT NULL,
    [Voornaam]                NVARCHAR (250)   NULL,
    [NationaliteitID]         NVARCHAR (50)    NULL,
    [GeboorteDatum]           DATETIME         NULL,
    [GeslachtID]              NVARCHAR (50)    NULL,
    [Beroep]                  NVARCHAR (2505)  NULL,
    [Telefoon]                NVARCHAR (50)    NULL,
    [Gsm]                     NVARCHAR (50)    NULL,
    [Fax]                     NVARCHAR (50)    NULL,
    [Email]                   NVARCHAR (50)    NULL,
    [IBAN]                    NVARCHAR (34)    NULL,
    [BIC]                     NVARCHAR (11)    NULL,
    [SoftDeleted]             BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION       NOT NULL,
    [IndieningPartijGUID]     UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PartijCategorieID]       NVARCHAR (15)    NULL,
    CONSTRAINT [PK_IndieningPartij] PRIMARY KEY CLUSTERED ([IndieningPartijID] ASC),
    CONSTRAINT [FK_IndieningPartij_Doelgroep] FOREIGN KEY ([DoelgroepID]) REFERENCES [IR].[Doelgroep] ([DoelgroepID]),
    CONSTRAINT [FK_IndieningPartij_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningPartij_IndieningPartij] FOREIGN KEY ([IndieningPartijParentID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID]),
    CONSTRAINT [FK_IndieningPartij_IndieningPartijType] FOREIGN KEY ([IndieningPartijTypeID]) REFERENCES [IR].[IndieningPartijType] ([IndieningPartijTypeID]),
    CONSTRAINT [FK_IndieningPartij_PartijCategorie] FOREIGN KEY ([PartijCategorieID]) REFERENCES [IR].[PartijCategorie] ([PartijCategorieID]),
    CONSTRAINT [FK_IndieningPartij_PartijType] FOREIGN KEY ([PartijTypeID]) REFERENCES [IR].[PartijType] ([PartijTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_IndieningPartij_IndieningID]
    ON [IR].[IndieningPartij]([IndieningID] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IX_IndieningPartij_IndieningPartijTypeID]
    ON [IR].[IndieningPartij]([IndieningPartijTypeID] ASC)
    ON [Indexes];


GO
CREATE NONCLUSTERED INDEX [IX_IndieningPartij_Naam]
    ON [IR].[IndieningPartij]([Naam] ASC)
    ON [Indexes];

