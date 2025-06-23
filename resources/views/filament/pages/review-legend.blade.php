{{-- resources/views/filament/pages/review-legend.blade.php --}}
<div class="space-y-6">
    <div>
        <h3 class="text-lg font-medium text-gray-900 dark:text-gray-100 mb-4">Keterangan Status Review</h3>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <h4 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Icon Status Item</h4>
                <div class="space-y-2 text-sm">
                    <div class="flex items-center space-x-2">
                        <span class="text-lg">✅</span>
                        <span>Auditee sudah mengisi</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="text-lg">⚠️</span>
                        <span>Auditee belum mengisi</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="text-lg">👤</span>
                        <span>Anda sudah review</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="text-lg">👥</span>
                        <span>Partner sudah review</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="text-lg">⏳</span>
                        <span>Belum review</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="text-lg">⚡</span>
                        <span>Ada konflik review</span>
                    </div>
                </div>
            </div>
            
            <div>
                <h4 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Badge Status Progress</h4>
                <div class="space-y-2 text-sm">
                    <div class="flex items-center space-x-2">
                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-success-100 text-success-800">100%</span>
                        <span>Review selesai</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-warning-100 text-warning-800">50%</span>
                        <span>Review sebagian</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-info-100 text-info-800">25%</span>
                        <span>Review mulai</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-800">0%</span>
                        <span>Belum dimulai</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-danger-100 text-danger-800">1</span>
                        <span>Jumlah konflik</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div>
        <h4 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Alur Review</h4>
        <div class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4">
            <ol class="list-decimal list-inside space-y-2 text-sm text-gray-600 dark:text-gray-400">
                <li>Auditee menyelesaikan pengisian audit</li>
                <li>Assignment muncul di daftar Review Audit</li>
                <li>Kedua auditor dapat melakukan review secara bersamaan atau berurutan</li>
                <li>Jika ada perbedaan temuan, akan muncul peringatan konflik</li>
                <li>Auditor dapat berdiskusi untuk mencapai konsensus</li>
                <li>Review selesai ketika kedua auditor telah menyelesaikan semua item</li>
            </ol>
        </div>
    </div>
    
    <div>
        <h4 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Tips Review</h4>
        <div class="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-4">
            <ul class="list-disc list-inside space-y-1 text-sm text-blue-700 dark:text-blue-300">
                <li>Periksa dengan teliti bukti dokumen yang dilampirkan auditee</li>
                <li>Berikan hasil pengamatan yang objektif dan konstruktif</li>
                <li>Komunikasikan dengan rekan auditor jika ada temuan yang berbeda</li>
                <li>Simpan sebagai draft jika belum yakin dengan review</li>
                <li>Pastikan semua item sudah direview sebelum menyelesaikan</li>
            </ul>
        </div>
    </div>
</div>