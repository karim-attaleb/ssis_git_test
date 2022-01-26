CREATE TABLE [FF].[WildRapport] (
    [IndieningID]                     INT        NOT NULL,
    [TotaleOppervlakte]               INT        NULL,
    [JachtplanDatum]                  DATETIME   NULL,
    [VoorjaarstellingAantalTerreinen] INT        NULL,
    [VoorjaarstellingSomOppervlakten] INT        NULL,
    [AfschotAantalTerreinen]          INT        NULL,
    [AfschotSomOppervlakten]          INT        NULL,
    [SoftDeleted]                     BIT        DEFAULT ((0)) NOT NULL,
    [RowVersion]                      ROWVERSION NOT NULL,
    CONSTRAINT [PK_WildRapport] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_WildRapport_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

