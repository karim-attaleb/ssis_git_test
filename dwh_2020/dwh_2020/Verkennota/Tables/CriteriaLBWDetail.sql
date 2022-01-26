CREATE TABLE [Verkennota].[CriteriaLBWDetail] (
    [CriteriaLBWDetailID]     INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]             INT            NOT NULL,
    [CriteriaLBWDetailTypeID] NVARCHAR (15)  NOT NULL,
    [Beschrijving]            NVARCHAR (MAX) NULL,
    [SoftDeleted]             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([CriteriaLBWDetailID] ASC),
    CONSTRAINT [FK_CriteriaLBWDetail_CriteriaLBWDetailType] FOREIGN KEY ([CriteriaLBWDetailTypeID]) REFERENCES [Verkennota].[CriteriaLBWDetailType] ([CriteriaLBWDetailTypeID]),
    CONSTRAINT [FK_CriteriaLBWDetail_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

