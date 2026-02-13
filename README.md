# 📊 Polymarket and Kalshi Metrics

**[View Dashboard on Dune](https://dune.com/blitzer/polymarket-and-kalshi)**

This dashboard provides a comparative analysis of the prediction market landscape, focusing on the two industry titans: **Polymarket** and **Kalshi**. It tracks volume trends, market share, and thematic dominance across decentralized and regulated prediction platforms.

The suite is designed for analysts and researchers to observe how event-based trading shifts across different regulatory environments and categorical interests.

---

## :camera_flash: Snapshot 
<img width="3734" height="4529" alt="image" src="https://github.com/user-attachments/assets/449ae1ae-7891-48b4-87ca-a8f2b41ae18e" />

---

## 🔍 Query Breakdown

### 1. Kalshi Volume By Market Categories

Focuses on the internal distribution of capital within the Kalshi ecosystem.

* **Thematic Aggregation:** Groups volume by Kalshi's native category labels to identify which sectors (e.g., Economics, Weather) drive the most activity.
* **Flexible Windows:** Utilizes a `Timeframe` parameter allowing users to switch between specific years, a rolling 365-day view, or all-time historical data.

### 2. Polymarket & Kalshi Daily Volume

A side-by-side comparison of daily trading activity to determine which platform leads the prediction market zeitgeist.

* **Platform Correlation:** Joins Polymarket (Polygon) and Kalshi trade data to visualize total daily market liquidity in USD.
* **Market Share Tracking:** Calculates the "polymarket_share_pct" to see how the decentralized market is performing relative to its regulated competitor.
* **Parameter Control:** Features a "Days Back" filter to let users zoom into recent volatility or long-term trends.

### 3. Polymarket Volume By Market Categories (Top 100 Unknown)

A specialized "cleanup" and discovery tool for Polymarket’s expansive and often unorganized market list.

* **Unknown Identification:** Specifically targets markets that do not fall into standard buckets (Elections, Sports, etc.) based on existing tags or question text.
* **Trend Spotting:** Lists the top 100 most liquid "Unknown" markets, helping analysts identify emerging niches or areas where the categorization logic needs refinement.

### 4. Polymarket Volume By Market Categories

Standardizes Polymarket’s decentralized data into a human-readable categorical structure.

* **Categorization Engine:** Employs complex logic to map raw tags and question keywords (e.g., "Trump," "CPI," "Champions League") into 16 distinct categories.
* **Time-Series Analysis:** Aggregates volume by week, providing a clear view of how specific interests (like "Elections" or "Science and Technology") wax and wane over time.

### 5. Polymarket vs. Kalshi Total Volume (Billions)

A high-level executive summary of the cumulative capital flowing through these platforms.

* **Scale Normalization:** Converts raw USD amounts into Billions for easier comparison of the total footprint of both markets.
* **Direct Comparison:** Provides a simple, two-row summary that highlights the total market size for each platform within the selected timeframe.

### 6. Polymarket vs. Kalshi by Market Category

Pits the two platforms against each other within specific market niches.

* **Standardized Mapping:** Cross-references Polymarket’s custom categories with Kalshi’s category structure to ensure an "apples-to-apples" comparison.
* **Competitive Insights:** Identifies the Top 5 most liquid categories globally and shows which platform is the preferred venue for each.

---

## 🛠️ Data Sources

* **Polymarket:** `polymarket_polygon.market_trades` & `polymarket_polygon.market_details`
* **Kalshi:** `kalshi.trade_report` & `kalshi.market_report`
