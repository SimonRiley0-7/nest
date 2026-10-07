import React, { useState } from 'react';
import { X, CheckCircle, ChevronRight, ChevronLeft, Building2, Plus, Trash2, FileText } from 'lucide-react';

export default function BuilderOnboardingWizard({ onClose, onComplete }) {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    companyName: 'Apex Urban Developers Pvt Ltd',
    contactDetails: '+91 98765 43210',
    schemes: 'Skyline Eco Towers & Smart Residences',
    unitConfigs: [
      { bhk: '1BHK', areaSqFt: '750', price: '5800000' },
      { bhk: '2BHK', areaSqFt: '1250', price: '9200000' },
      { bhk: '3BHK', areaSqFt: '1850', price: '13500000' },
    ],
    location: 'Whitefield Main Rd, Bangalore',
    reraNo: 'PRM/KA/RERA/1251/310/PR/260115',
    surroundings: 'Top IT Parks within 1km, Metro 600m',
  });

  const totalSteps = 8;

  const handleNext = () => {
    if (step < totalSteps) setStep(step + 1);
    else onComplete(formData);
  };

  const handlePrev = () => {
    if (step > 1) setStep(step - 1);
  };

  const addConfig = () => {
    setFormData({
      ...formData,
      unitConfigs: [...formData.unitConfigs, { bhk: '2BHK', areaSqFt: '1100', price: '8500000' }]
    });
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-fadeIn">
      <div className="glass-card max-w-xl w-full rounded-2xl p-6 space-y-6 border border-amber-500/30 max-h-[90vh] overflow-y-auto">
        {/* Progress Header */}
        <div className="flex items-center justify-between border-b border-slate-800 pb-3">
          <div>
            <span className="text-xs text-amber-400 font-bold uppercase tracking-wider">Builder Project Wizard</span>
            <h2 className="text-lg font-bold text-white">Step {step} of {totalSteps}</h2>
          </div>
          <button onClick={onClose} className="p-1 rounded-lg bg-slate-800 text-slate-400 hover:text-white">
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="w-full h-1.5 bg-slate-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-amber-500 to-orange-500 transition-all duration-300"
            style={{ width: `${(step / totalSteps) * 100}%` }}
          />
        </div>

        {/* Step Contents */}
        <div className="space-y-4">
          {step === 1 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 1: Company & Contact Details</h3>
              <div>
                <label className="text-xs text-slate-400 block mb-1">Developer Company Name</label>
                <input
                  type="text"
                  value={formData.companyName}
                  onChange={(e) => setFormData({ ...formData, companyName: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-amber-500"
                />
              </div>
              <div>
                <label className="text-xs text-slate-400 block mb-1">Corporate Contact Number</label>
                <input
                  type="text"
                  value={formData.contactDetails}
                  onChange={(e) => setFormData({ ...formData, contactDetails: e.target.value })}
                  className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-amber-500"
                />
              </div>
            </div>
          )}

          {step === 2 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 2: Schemes & Projects Offered</h3>
              <label className="text-xs text-slate-400 block">Project / Scheme Name</label>
              <input
                type="text"
                value={formData.schemes}
                onChange={(e) => setFormData({ ...formData, schemes: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-amber-500"
              />
            </div>
          )}

          {step === 3 && (
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <h3 className="font-bold text-white text-base">Step 3: Unit Configurations Matrix</h3>
                <button
                  onClick={addConfig}
                  className="px-2.5 py-1 rounded-lg bg-amber-500/20 text-amber-300 text-xs font-bold border border-amber-500/30 flex items-center gap-1"
                >
                  <Plus className="w-3.5 h-3.5" /> Add Config
                </button>
              </div>
              
              <div className="space-y-2">
                {formData.unitConfigs.map((cfg, idx) => (
                  <div key={idx} className="bg-slate-900 p-3 rounded-xl border border-slate-800 grid grid-cols-3 gap-2 text-xs">
                    <div>
                      <span className="text-[10px] text-slate-400 block">BHK Type</span>
                      <input
                        type="text"
                        value={cfg.bhk}
                        onChange={(e) => {
                          const updated = [...formData.unitConfigs];
                          updated[idx].bhk = e.target.value;
                          setFormData({ ...formData, unitConfigs: updated });
                        }}
                        className="w-full bg-slate-950 border border-slate-800 rounded px-2 py-1 text-white font-bold"
                      />
                    </div>
                    <div>
                      <span className="text-[10px] text-slate-400 block">Area (Sq Ft)</span>
                      <input
                        type="text"
                        value={cfg.areaSqFt}
                        onChange={(e) => {
                          const updated = [...formData.unitConfigs];
                          updated[idx].areaSqFt = e.target.value;
                          setFormData({ ...formData, unitConfigs: updated });
                        }}
                        className="w-full bg-slate-950 border border-slate-800 rounded px-2 py-1 text-white"
                      />
                    </div>
                    <div>
                      <span className="text-[10px] text-slate-400 block">Price (₹)</span>
                      <input
                        type="text"
                        value={cfg.price}
                        onChange={(e) => {
                          const updated = [...formData.unitConfigs];
                          updated[idx].price = e.target.value;
                          setFormData({ ...formData, unitConfigs: updated });
                        }}
                        className="w-full bg-slate-950 border border-slate-800 rounded px-2 py-1 text-amber-400 font-mono font-bold"
                      />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {step === 4 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 4: Project Location</h3>
              <input
                type="text"
                value={formData.location}
                onChange={(e) => setFormData({ ...formData, location: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-amber-500"
              />
            </div>
          )}

          {step === 5 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 5: Business Registration & RERA Details</h3>
              <label className="text-xs text-slate-400 block">Government RERA Registration Number</label>
              <input
                type="text"
                value={formData.reraNo}
                onChange={(e) => setFormData({ ...formData, reraNo: e.target.value })}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-amber-500 font-mono text-xs"
              />
            </div>
          )}

          {step === 6 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 6: Per-Property Photos & Walkthrough Videos</h3>
              <p className="text-xs text-slate-400">Upload 3D walkthrough renders, site progress photos, and floor plans.</p>
              <div className="border border-slate-800 bg-slate-900 p-4 rounded-xl text-center text-xs text-slate-400">
                5 High-Resolution Renders Uploaded
              </div>
            </div>
          )}

          {step === 7 && (
            <div className="space-y-3">
              <h3 className="font-bold text-white text-base">Step 7: Infrastructure & Surrounding Area</h3>
              <textarea
                value={formData.surroundings}
                onChange={(e) => setFormData({ ...formData, surroundings: e.target.value })}
                rows={3}
                className="w-full bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-sm text-white focus:border-amber-500"
              />
            </div>
          )}

          {step === 8 && (
            <div className="space-y-4 text-center py-2">
              <div className="w-12 h-12 rounded-full bg-amber-500/20 text-amber-400 mx-auto flex items-center justify-center">
                <CheckCircle className="w-6 h-6" />
              </div>
              <h3 className="font-bold text-white text-lg">Step 8: Review & Publish Builder Project</h3>
              <p className="text-xs text-slate-400 max-w-md mx-auto">
                Project will be listed with customizable discount badges, flash ad promotion eligibility, and live buyer view analytics.
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
            className="px-5 py-2.5 rounded-xl bg-gradient-to-r from-amber-600 to-orange-600 hover:from-amber-500 hover:to-orange-500 text-white font-bold text-xs shadow-lg flex items-center gap-1"
          >
            <span>{step === totalSteps ? 'Publish Builder Project' : 'Next Step'}</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  );
}
