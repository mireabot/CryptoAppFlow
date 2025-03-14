![Cover Image](https://github.com/mireabot/CryptoAppFlow/blob/main/CryptoAppFlowCover.png)
# Building Crypto iOS App Flow with AlexSidebar

## Architecture Overview

The project follows a service-based architecture with the following key components:

### Services
- **WalletService**: Manages the wallet state and operations
- **ContractService**: Handles contract-related operations and state management

### Navigation
- Uses SwiftUI's NavigationStack for flow management
- Implements a path-based navigation system using an enum `SendFlowScreen` to handle different screens in the send flow

### UI Components
The UI is organized into modular views:
- **WalletDashboard**: Main entry point of the app
- **SendFlow**: Contains the complete flow for sending crypto
  - RecipientsSelection
  - AssetSelection
  - ContractDetailsEntry
  - ContractSummaryView

### Design Pattern
- Follows MVVM-like pattern using SwiftUI's native state management
- Uses `@StateObject` for service instances
- Implements environment objects for dependency injection
- Utilizes SwiftUI's built-in state management with `@State` and `@Binding`

---
YouTube video is available [here](https://youtu.be/TvsjJ3Hk8BM)<br/>
[Download](https://alexcodes.app/) AlexSidebar
