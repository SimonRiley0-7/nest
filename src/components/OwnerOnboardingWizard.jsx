import React, { useState } from 'react';
import { X, CheckCircle, ChevronRight, ChevronLeft, Upload, MapPin, FileText, Sparkles, Building2 } from 'lucide-react';

export default function OwnerOnboardingWizard({ onClose, onComplete }) {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    name: 'Rajesh Kumar',
    phone: '+91 91234 56789',
    ownershipDuration: '3.5 Years',
    sellingPrice: '24000000',
    photos: ['uploaded_villa_1.jpg', 'uploaded_lawn.jpg'],
    buildingAge: '3.5 Years',
    location: 'Koregaon Park, Pune',
    surroundings: 'Top international schools within 2km, hospitals 1km, market 500m',
    legalDocs: ['712_extract.pdf', 'property_tax_receipt_2026.pdf'],
  });

  const totalSteps = 8;

  const handleNext = () => {
    if (step < totalSteps) setStep(step + 1);
    else onComplete(formData);
  };

  const handlePrev = () => {
    if (step > 1) setStep(step - 1);
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-xl w-full rounded-2xl p-6 space-y-6 border border-emerald-500/30 max-h-[90vh] overflow-y-auto">
        {/* Progress Header */}
        <div className="flex items-center justify-between border-b border-slate-800 pb-3">
          <div>
            <span className="text-xs text-emerald-400 font-bold uppercase tracking-wider">Owner Listing Wizard</span>
            <h2 className="text-lg font-bold text-white">Step {step} of {totalSteps}</h2>
          </div>
          <button onClick={onClose} className="p-1 rounded-lg bg-slate-800 text-slate-400 hover:text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Progress Bar */}
        <div className="w-full h-1.5 bg-slate-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-emerald-500 to-teal-400 transition-all duration-300"
            style={{ width: `${(step / totalSteps) * 100}%` }}
          />
        </div>

        {/* Step Contents */}
        <div className="space-y-4">
          {step === 1 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 1: Contact Details</h3>
              <div>
                <label className="text-xs text-slate-400 block mb-1">Owner Name</label>
                <input
                  type="text"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500"
                />
              </div>
              <div>
                <label className="text-xs text-slate-400 block mb-1">Contact Phone</label>
                <input
                  type="text"
                  value={formData.phone}
                  onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500"
                />
              </div>
            </div>
          )}

          {step === 2 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 2: Duration of Ownership</h3>
              <label className="text-xs text-slate-400 block">How long have you owned this property?</label>
              <select
                value={formData.ownershipDuration}
                onChange={(e) => setFormData({ ...formData, ownershipDuration: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500"
              >
                <option>Less than 1 Year</option>
                <option>1 - 3 Years</option>
                <option>3.5 Years</option>
                <option>5+ Years</option>
              </select>
            </div>
          )}

          {step === 3 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 3: Selling Price</h3>
              <label className="text-xs text-slate-400 block">Expected Selling Price (in INR ₹)</label>
              <input
                type="number"
                value={formData.sellingPrice}
                onChange={(e) => setFormData({ ...formData, sellingPrice: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500 font-mono text-lg font-bold"
              />
              <span className="text-xs text-emerald-400 font-semibold">₹{(Number(formData.sellingPrice) / 10000000).toFixed(2)} Crores</span>
            </div>
          )}

          {step === 4 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 4: Photos & Videos</h3>
              <div className="border-2 border-dashed border-slate-700 rounded-xl p-6 text-center space-y-2 bg-slate-900/50">
                <Upload className="w-8 h-8 text-emerald-400 mx-auto animate-bounce" />
                <div className="text-xs text-slate-300 font-semibold">Drag & Drop Property Media</div>
                <p className="text-[11px] text-slate-500">Supports JPG, PNG, MP4 up to 50MB</p>
              </div>
              <div className="text-xs text-slate-400">Attached: {formData.photos.join(', ')}</div>
            </div>
          )}

          {step === 5 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 5: Building Details & Location</h3>
              <div>
                <label className="text-xs text-slate-400 block mb-1">Building Age</label>
                <input
                  type="text"
                  value={formData.buildingAge}
                  onChange={(e) => setFormData({ ...formData, buildingAge: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500"
                />
              </div>
              <div>
                <label className="text-xs text-slate-400 block mb-1">Exact Area / City Location</label>
                <input
                  type="text"
                  value={formData.location}
                  onChange={(e) => setFormData({ ...formData, location: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500"
                />
              </div>
            </div>
          )}

          {step === 6 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 6: Surrounding Area Details</h3>
              <label className="text-xs text-slate-400 block">Nearby Schools, Hospitals, Metro, Markets</label>
              <textarea
                value={formData.surroundings}
                onChange={(e) => setFormData({ ...formData, surroundings: e.target.value })}
                rows={3}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-emerald-500"
              />
            </div>
          )}

          {step === 7 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 7: Legal Documents Upload</h3>
              <p className="text-xs text-slate-400">Title Deed, Tax Receipts, 7/12 Extract for Watermarked Protection Vault</p>
              <div className="border border-slate-800 bg-slate-900 p-3 rounded-xl text-xs space-y-1">
                {formData.legalDocs.map((doc, i) => (
                  <div key={i} className="flex items-center justify-between text-slate-300">
                    <span className="flex items-center gap-1.5"><FileText className="w-3.5 h-3.5 text-amber-400" /> {doc}</span>
                    <span className="text-emerald-400 font-bold">Uploaded</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          {step === 8 && (
            <div className="space-y-4 text-center py-2">
              <div className="w-12 h-12 rounded-full bg-emerald-500/20 text-emerald-400 mx-auto flex items-center justify-center">
                <CheckCircle className="w-6 h-6" />
              </div>
              <h3 className="font-bold text-white text-lg">Step 8: Review & Publish Listing</h3>
              <p className="text-xs text-slate-400 max-w-md mx-auto">
                Your owner property will be published immediately to the marketplace with encrypted document protection and Uber-style call masking enabled.
              </p>
            </div>
          )}
        </div>

        {/* Wizard Controls */}
        <div className="flex items-center justify-between pt-4 border-t border-slate-800">
          <button
            onClick={handlePrev}
            disabled={step === 1}
            className={`px-4 py-2 rounded-xl text-xs font-semibold flex items-center gap-1 ${
              step === 1 ? 'opacity-40 text-slate-600' : 'bg-slate-800 text-slate-200 hover:bg-slate-700'
            }`}
          >
            <ChevronLeft className="w-4 h-4" /> Back
          </button>
          <button
            onClick={handleNext}
            className="px-5 py-2.5 rounded-xl bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white font-bold text-xs shadow-lg flex items-center gap-1"
          >
            <span>{step === totalSteps ? 'Publish Owner Listing' : 'Next Step'}</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  );
}
