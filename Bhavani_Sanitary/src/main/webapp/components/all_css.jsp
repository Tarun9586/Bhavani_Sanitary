<!-- Required for mobile responsiveness -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">

<style>
    /* Loader & Overlay */
    #top-loader { position: fixed; top: 0; left: 0; width: 0%; height: 3px; background-color: #2874f0; z-index: 11000; transition: width 0.4s ease; }
    #page-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: #ffffff; z-index: 10900; display: flex; justify-content: center; align-items: center; transition: opacity 0.5s ease; }
    .loader-hidden { opacity: 0 !important; visibility: hidden !important; }

    /* Fix for Dropdown visibility */
    .navbar { z-index: 1030; } 
    .dropdown-menu { z-index: 1040; }

    /* Responsive Image Styling */
    .img-admin { max-width: 80px; width: 100%; height: auto; border-radius: 4px; object-fit: cover; }

    /* Table Responsiveness Fix */
    .table-container { width: 100%; overflow-x: auto; -webkit-overflow-scrolling: touch; }
    
    /* Sidebar Layout */
    .sidebar { height: 100vh; overflow-y: auto; background: #f8f9fa; }
    
    @media (max-width: 768px) {
        .sidebar { display: none; }
        .content-area { padding-top: 20px; }
        /* Ensures dropdown doesn't get hidden by navbar overflow on mobile */
        .navbar-collapse { overflow-y: auto; max-height: 80vh; }
    }
</style>