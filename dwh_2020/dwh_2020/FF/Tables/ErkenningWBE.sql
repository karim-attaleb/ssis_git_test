CREATE TABLE [FF].[ErkenningWBE] (
    [IndieningID]              INT           NOT NULL,
    [StichtingsDatum]          DATETIME      NULL,
    [AantalLeden]              INT           NULL,
    [AantalTerreinen]          INT           NULL,
    [SomOppervlaktenTerreinen] INT           NULL,
    [ErkenningType]            NVARCHAR (15) NULL,
    [Vervaldatum]              DATETIME      NULL,
    [CheckBijlage1]            BIT           NULL,
    [CheckBijlage2]            BIT           NULL,
    [CheckBijlage3]            BIT           NULL,
    [CheckBijlage4]            BIT           NULL,
    [GoedgekeurdDatum]         DATETIME      NULL,
    [ErkenningsDatum]          DATETIME      NULL,
    [AfgekeurdDatum]           DATETIME      NULL,
    [IngetrokkenDatum]         DATETIME      NULL,
    [SoftDeleted]              BIT           CONSTRAINT [DF_ErkenningWBE_SoftDeleted] DEFAULT ((0)) NOT NULL,
    [RowVersion]               ROWVERSION    NOT NULL,
    CONSTRAINT [PK_ErkenningWBE] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_ErkenningWBE_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

